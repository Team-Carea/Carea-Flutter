import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/data/services/chat_room_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ChatRoomService chatRoomService = ChatRoomService();

  @override
  void initState() {
    super.initState();
    // chatRoomService.initializeWebsocket();
    // 웹소켓을 통해 서버로부터의 이벤트 수신 대기
    // chatRoomService.channel.stream.listen((event) {
    //   chatRoomService.onMessageReceived(event);
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Chat(
        messages: chatRoomService.messages,
        onSendPressed: _handleSendPressed,
        // showUserNames: true, // 메시지마다 username 보이지 않게 수정
        user: chatRoomService.user1,
        theme: const DefaultChatTheme(
          primaryColor: AppColors.greenPrimaryColor,
          secondaryColor: AppColors.faintGray,
          inputBackgroundColor: AppColors.lightBlueGray,
          inputTextColor: AppColors.black,
          backgroundColor: AppColors.white,
          inputBorderRadius: BorderRadius.zero,
          receivedMessageBodyTextStyle: TextStyle(color: Colors.black),
          // 보낸 메시지 스타일
          sentMessageBodyTextStyle: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
          attachmentButtonIcon: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          seenIcon: Text(
            'read',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
          // 모든 user들의 이름 색상을 검은색으로 설정
          userAvatarNameColors: [
            Colors.black,
          ],
          userNameTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            height: 1.333,
          ),
        ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    if (!chatRoomService.isLoading) {
      final textMessage = types.TextMessage(
        author: chatRoomService.user1,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(), // 각 메시지의 id
        text: message.text,
      );

      chatRoomService.addMessage(textMessage);
      setState(() {});
    }
  }
}
