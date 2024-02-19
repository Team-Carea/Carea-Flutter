import 'package:dio/dio.dart';
import 'package:carea/app/common/const/config.dart';

class ChatRoomService {
  final Dio dio = Dio();

  // GET: 채팅방 목록 조회
  Future<List<Map<String, dynamic>>> getChatRoomList() async {
    // TODO: develop 브랜치 함수 활용해서 리팩토링
    // final accessToken = AuthStorage.getAccessToken();
    const accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4Mzc5NjA2LCJpYXQiOjE3MDgzNzI0MDYsImp0aSI6IjEwNTY3NThlYWJlZjQ1Njk4YzM3NTA0NDBmNjlmOGIxIiwidXNlcl9pZCI6Mn0.qeWyCoSQ04BSzHmE5lioeZ-SfO5r8L9b_LPGlN3bxzE';

    final response = await dio.get(
      'http://${AppConfig.localHost}/${AppConfig.chatRoomListUrl}/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

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
