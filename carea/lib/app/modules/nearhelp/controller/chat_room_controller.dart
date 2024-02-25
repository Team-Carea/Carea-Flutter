import 'package:carea/app/common/component/toast_popup.dart';
import 'package:carea/app/common/util/auth_storage.dart';

import 'package:dio/dio.dart';

class ChatRoom {
  final Dio dio = Dio();

  Future<void> createChatRoom() async {
    final accessToken = await AuthStorage.getAccessToken();
    String baseUrl = 'http://10.0.2.2:8000/chats/rooms/';
    try {
      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          // 'help': detailId,
        },
      );
      if (response.statusCode == 201) {
        careaToast(toastMsg: '채팅을 시작합니다');
      } else if (response.statusCode == 200) {
        careaToast(toastMsg: '기존 채팅방으로 이동합니다');
      } else if (response.statusCode == 403) {
        careaToast(toastMsg: '본인의 도움글입니다');
      }
    } catch (error) {
      print('채팅하기 오류: $error');
    }
  }
}
