import 'dart:convert';

import 'package:carea/app/common/const/config.dart';
import 'package:carea/app/common/util/auth_storage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HelpConfirmService {
  late WebSocketChannel channel;
  bool isInitialized = false;
  Function? onResponse;

  Future<void> initializeWebsocket(String roomId) async {
    final accessToken = await AuthStorage.getAccessToken();
    channel = IOWebSocketChannel.connect(
        'ws://${AppConfig.localHost}/${AppConfig.nearHelpSttUrl}/$roomId?token=$accessToken');

    isInitialized = true; // 웹소켓 연결 초기화 완료
    channel.stream.listen((event) {
      // 웹소켓을 통해 서버로부터의 이벤트 수신 대기
      noticeResponse(event);
    });
  }

  void sendSentence(String sentence) {
    if (isInitialized) {
      final sentencePayload = jsonEncode({
        'type': 'text',
        'message': sentence,
      });
      channel.sink.add(sentencePayload);
    } else {
      print("WebSocket is not initialized.");
    }
  }

  void noticeResponse(event) {
    final response = jsonDecode(event);
    // 콜백 함수 호출
    if (onResponse != null) {
      onResponse!();
    }
  }

  void dispose() {
    if (isInitialized) {
      channel.sink.close();
    }
  }
}
