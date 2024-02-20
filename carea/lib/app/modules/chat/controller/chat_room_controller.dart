import 'package:carea/app/data/services/chat_room_service.dart';

class ChatRoomController {
  final ChatRoomService _chatRoomService = ChatRoomService();

  Future<List<Map<String, dynamic>>> fetchChatRooms() async {
    return await _chatRoomService.getChatRoomList();
  }
}
