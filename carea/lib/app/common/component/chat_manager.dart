import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatManager {
  final List<types.Message> messages = [];
  final user = const types.User(
    id: 'exampleId', // 사용자의 id로 지정
  );

  void addMessage(types.Message message) {}
}
