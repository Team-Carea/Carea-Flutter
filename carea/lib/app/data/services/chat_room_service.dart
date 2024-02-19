import 'package:carea/app/common/const/config.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatService {
  final List<types.Message> messages = [];
  final user1 = const types.User(
    id: '1', // 나의 id
  );
  final user2 = const types.User(
    id: '2', // 상대방의 id
    firstName: '지니신',
  );
  bool isLoading = false;
  late WebSocketChannel channel;
  final String roomId = '';

  // 웹소켓 연결 초기화
  void initializeWebsocket() {
    channel = IOWebSocketChannel.connect(
        'ws://${AppConfig.localHost}${AppConfig.chatRoomUrl}/$roomId');
  }

  void addMessage(types.Message message) {
    messages.insert(0, message); // 화면 맨 아래에 메시지 추가
    isLoading = true;
    if (message is types.TextMessage) {
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

  void onMessageReceived(response) {
    if (response == '<FIN>') {
      isLoading = false;
    } else {
      // 채팅방의 마지막 메시지를 전달받은 내용으로 변경
      messages.first = (messages.first as types.TextMessage).copyWith(
          text: (messages.first as types.TextMessage).text + response);
    }
  }
}
