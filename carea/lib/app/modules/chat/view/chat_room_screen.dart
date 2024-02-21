import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/data/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../help_confirm/view/helper_confirm_screen.dart';

class ChatRoomScreen extends StatefulWidget {
  final int id;

  const ChatRoomScreen({super.key, required this.id});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ChatService chatRoomService = ChatService();

  @override
  void initState() {
    super.initState();
    chatRoomService.initializeWebsocket();
    // 웹소켓을 통해 서버로부터의 이벤트 수신 대기
    chatRoomService.channel.stream.listen((event) {
      chatRoomService.onMessageReceived(event);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String titleName = chatRoomService.user2.firstName!;

    return DefaultLayout(
      appbar: AppBar(
        centerTitle: true,
        title: Text(titleName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ConfirmHelpScreen(),
                //   ),
                // );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.black,
                backgroundColor: AppColors.yellowPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
              ).copyWith(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 8)),
              ),
              child: const Text('도움 인증'),
            ),
          ),
        ],
      ),
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
