import 'package:carea/app/common/util/auth_storage.dart';
import 'package:dio/dio.dart';
import 'package:carea/app/common/const/config.dart';

class ChatRoomService {
  final Dio dio = Dio();

  // GET: 채팅방 목록 조회
  Future<List<Map<String, dynamic>>> getChatRoomList() async {
    // TODO: develop 브랜치 함수 활용해서 리팩토링
    // final accessToken = await AuthStorage.getAccessToken();
    // print(accessToken.toString());
    const accessToken =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NjE5OTU1LCJpYXQiOjE3MDg0NDcxNTUsImp0aSI6ImM5ZGQ0NjJiODcyOTQwMWRhODE3MjY3YzIxOWZkNjA4IiwidXNlcl9pZCI6Mn0.R2fMfKYULnTC1thLTTsJiI3ubvpu4IlOPfZA1maSxQs';
    // AuthStorage.saveAccessToken(accessToken);

    final response = await dio.get(
      'http://${AppConfig.localHost}/${AppConfig.chatRoomListUrl}/',
      options: Options(
        headers: {
          'Authorization': accessToken,
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

  // GET: 채팅 메시지 목록 조회
}
