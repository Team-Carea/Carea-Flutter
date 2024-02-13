import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carea/app/common/component/toast_popup.dart';

// 도움 등록하기 post API
Future<void> sendPostRequest() async {
  const url = 'http://10.0.2.2:8000/helps';

  String nickname = '캐리아';
  Object user = 34562;
  String title = '00시 00분 숙대 정문 앞에서 도움을 요청합니다';
  String content = '함께 OO하고 인증해요!';
  String postedAt = DateTime.now().toIso8601String();

  BaseOptions options = BaseOptions(
    contentType: 'application/x-www-form-urlencoded',
  );
  Dio dio = Dio(options);

  try {
    final response = await dio.post(
      url,
      data: {
        'nickname': nickname,
        'user': user,
        'title': title,
        'content': content,
        'posted_at': postedAt,
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');
    return careaToast(toastMsg: '도움이 제대로 등록되지 않았습니다.');
  } catch (e) {
    return careaToast(toastMsg: '도움이 제대로 등록되지 않았습니다.');
  }
}
