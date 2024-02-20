import 'dart:convert';
import 'package:carea/app/common/const/config.dart';

class ChatRoomService {
  final List<types.Message> messages = [];
  final user1 = const types.User(
    id: '2', // 나의 id
  );
  final user2 = const types.User(
    id: '3', // 상대방의 id
    firstName: '지니신',
  );
  bool isLoading = false;
  late WebSocketChannel channel;
  final String roomId = '1'; // 임시 채팅방 Id
  final String accessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NDQ2MjIxLCJpYXQiOjE3MDg0MzkwMjEsImp0aSI6IjZlY2ZkMWQ3YzE3YzQ3NTQ4NDRiNGMyODU2ZmEwZTJlIiwidXNlcl9pZCI6Mn0.N7PGt424kHXJfX5UCJPEOMhFsC71y0itgWz2fp8dwVY';

  // 웹소켓 연결 초기화
  void initializeWebsocket() {
    channel = IOWebSocketChannel.connect(
        'ws://${AppConfig.localHost}${AppConfig.chatRoomUrl}/$roomId?token=$accessToken');
  }

  void addMessage(types.Message message) {
    messages.insert(0, message); // 화면 맨 아래에 메시지 추가
    isLoading = true;
    if (message is types.TextMessage) {
      // 문제점: 백엔드가 원하는 형태로 보내주지 않음
      final messagePayload = jsonEncode({
        'user_id': user1.id,
        'message': message.text,
      });

      channel.sink.add(messagePayload);
      // channel.sink.add(message.text); // 메시지를 백엔드(웹소켓 서버)로 전송
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

    if (response.statusCode == 200) {
      List<dynamic> rawData = response.data;
      return rawData
          .map<Map<String, dynamic>>((i) => i as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to load chat room list');
    }
  }
}
