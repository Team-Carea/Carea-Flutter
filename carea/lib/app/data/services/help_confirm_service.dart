import 'dart:convert';

import 'package:carea/app/common/const/config.dart';
import 'package:carea/app/common/util/auth_storage.dart';
import 'package:carea/app/data/models/gemini_data_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HelpConfirmService {
  late WebSocketChannel channel;
  bool isInitialized = false;
  Function? onMyResponse;
  Function? onOtherResponse;

  Future<void> initializeWebsocket(String roomId) async {
    final accessToken = await AuthStorage.getAccessToken();
    channel = IOWebSocketChannel.connect(
        'ws://${AppConfig.localHost}/${AppConfig.nearHelpSttUrl}/$roomId?token=$accessToken');

    isInitialized = true;
    channel.stream.listen((event) {
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
    if (onMyResponse != null) {
      onMyResponse!();
    }
    if (onOtherResponse != null) {
      final receivedSentence = GeminiResponseModel.fromWebSocketJson(response);
      onOtherResponse!(receivedSentence.text);
    }
  }

  void dispose() {
    if (isInitialized) {
      channel.sink.close();
    }
  }
}
