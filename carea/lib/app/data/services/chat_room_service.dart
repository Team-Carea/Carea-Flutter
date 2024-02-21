import 'package:carea/app/common/util/auth_storage.dart';
import 'package:carea/app/data/models/chat_message_list_model.dart';
import 'package:carea/app/data/models/chat_room_list_model.dart';
import 'package:dio/dio.dart';
import 'package:carea/app/common/const/config.dart';

class ChatRoomService {
  final Dio dio = Dio();

  // GET: 채팅방 목록 조회
  Future<ChatRoomList> getChatRoomList() async {
    final accessToken = await AuthStorage.getAccessToken();
    try {
      final response = await dio.get(
        'http://${AppConfig.localHost}/${AppConfig.chatRoomListUrl}/',
        options: Options(
          headers: {
            'Authorization': accessToken,
          },
        ),
      );

      if (response.statusCode == 200) {
        return ChatRoomList.fromJson(response.data);
      } else {
        throw Exception('Failed to load chat room list');
      }
    } on DioException catch (e) {
      print(e.toString());
      throw Exception('Failed to load chat messages with DioError');
    }
  }

  // GET: 채팅 메시지 목록 조회
  Future<ChatMessageList> getChatMessages(String roomId) async {
    final accessToken = await AuthStorage.getAccessToken();
    try {
      final response = await dio.get(
        'http://${AppConfig.localHost}/chats/$roomId/messages/',
        options: Options(
          headers: {
            'Authorization': accessToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return ChatMessageList.fromJson(response.data);
      } else {
        print('Failed to load chat messages');
        throw Exception('Failed to load chat messages');
      }
    } on DioException catch (e) {
      print(e.toString());
      throw Exception('Failed to load chat messages with DioError');
    }
  }
}
