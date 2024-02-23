import 'package:carea/app/common/component/custom_button.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:carea/app/data/models/chat_message_list_model.dart';
import 'package:carea/app/data/models/chat_room_list_model.dart';
import 'package:carea/app/data/services/chat_room_service.dart';
import 'package:carea/app/data/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatRoomScreen extends StatefulWidget {
  final int id;
  final Opponent opponent;

  const ChatRoomScreen({
    super.key,
    required this.id,
    required this.opponent,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ChatService chatService = ChatService();
  final ChatRoomService chatRoomService = ChatRoomService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // 채팅목록 상태관리를 위한 변수
  List<ChatMessage> messages = [];
  int? currentOpponentUserId;
  String? currentUserType;
  bool isCurrentUserTypeInitialized = false;

  @override
  void initState() {
    super.initState();
    chatService.initializeWebsocket();
    chatService.onMessageCallback = (ChatMessage message) {
      setState(() {
        messages.add(message);
      });
    };
    loadChatMessages(widget.id.toString());
    setCurrentUserType(widget.id.toString());
    currentOpponentUserId = widget.opponent.id;
  }

  Future<void> loadChatMessages(String roomId) async {
    try {
      List<ChatMessage> chatMessageList =
          await chatRoomService.getChatMessages(roomId);
      setState(() {
        messages = chatMessageList;
      });
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  Future<void> setCurrentUserType(String roomId) async {
    String userType = await chatRoomService.getUserType(roomId);
    setState(() {
      currentUserType = userType;
      isCurrentUserTypeInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String roomId = widget.id.toString();
    return DefaultLayout(
      appbar: AppBar(
        centerTitle: true,
        title: Text(widget.opponent.nickname),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            chatService.dispose();
            // 가장 최신 메시지 정보 return
            ChatMessage updatedLatestMessage = messages[messages.length - 1];
            return Navigator.of(context).pop(updatedLatestMessage);
          },
        ),
        actions: <Widget>[
          if (isCurrentUserTypeInitialized)
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: helpComfirmButton(
                currentUserType: currentUserType!,
                roomId: roomId,
              ),
            ),
        ],
      ),
      bottomsheet: _buildBottomChatInput(),
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          var message = messages[messages.length - 1 - index];
          bool isSentByCurrentUser = message.user == currentOpponentUserId;
          return _buildChatMessage(isSentByCurrentUser, context, message);
        },
      ),
    );
  }

  Widget _buildBottomChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 60.0,
      color: AppColors.lightBlueGray,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: "메시지를 입력하세요",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _handleSendPressed();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(
      bool isSentByCurrentUser, BuildContext context, ChatMessage message) {
    return Padding(
      padding: isSentByCurrentUser
          ? const EdgeInsets.only(right: 8.0)
          : const EdgeInsets.only(left: 8.0),
      child: Container(
        alignment:
            isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: isSentByCurrentUser
              ? const EdgeInsets.only(left: 40, bottom: 14)
              : const EdgeInsets.only(right: 40, bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSentByCurrentUser
                ? AppColors.greenPrimaryColor
                : AppColors.extraLightGray,
            borderRadius: isSentByCurrentUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
          ),
          constraints: BoxConstraints(
            maxWidth: getScreenWidth(context) * 0.7,
          ),
          child: Text(
            message.message,
            // message.message + message.id.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            softWrap: true,
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    );
  }

  void _handleSendPressed() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        final newMessage = ChatMessage(
          id: const Uuid().hashCode,
          message: _controller.text,
          createdAt: DateTime.now(),
          user: currentOpponentUserId!,
        );
        messages.add(newMessage);
        chatService.addMessage(newMessage);
      });
      _controller.clear();
    }
    // 화면 하단으로 스크롤 이동
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
