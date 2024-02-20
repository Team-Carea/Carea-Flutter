import 'dart:convert';
import 'package:carea/app/common/const/config.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRoomService {
  final List<types.Message> messages = [];
  final user1 = const types.User(
    id: '2', // 나(자준청)의 id
  );
  final user2 = const types.User(
    id: '3', // 상대방(캐리아)의 id
    firstName: '캐리아',
  );
  bool isLoading = false;
  late WebSocketChannel channel;
  final String roomId = '1'; // 임시 채팅방 Id
  final String accessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NDU0MTMyLCJpYXQiOjE3MDg0NDY5MzIsImp0aSI6ImZjNzhkMjA1Mzk0MzQxMjc4NjIxNDNjZmQ2MmU4YThkIiwidXNlcl9pZCI6Mn0.P4jWsv7Ai3ULQv59tpjxttXtzR1DRpnmx1A2Wpg4x0s';

  // 웹소켓 연결 초기화
  void initializeWebsocket() {
    channel = IOWebSocketChannel.connect(
        'ws://${AppConfig.localHost}/${AppConfig.chatRoomUrl}/$roomId?token=$accessToken');
  }

  // 화면에 메시지 추가 및 전송
  void addMessage(types.Message message) {
    messages.insert(0, message); // 화면 맨 아래에 메시지 추가
    isLoading = true;
    if (message is types.TextMessage) {
      final messagePayload = jsonEncode({
        'user_id': user1.id,
        'message': message.text,
      });
      channel.sink.add(messagePayload);
      messages.insert(
        0,
        types.TextMessage(
          author: user2,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "",
        ),
      );
    }
  }

  // 메시지 전송요청 처리
  void onMessageReceived(response) {
    if (response == '<FIN>') {
      isLoading = false;
    } else {
      // 채팅방의 마지막 메시지를 전달받은 내용으로 변경
      messages.first = (messages.first as types.TextMessage).copyWith(
          text: (messages.first as types.TextMessage).text + response);
    }
  }

  // 웹소켓 연결 종료
  void closeWebsocket() {
    channel.sink.close();
  }
}
