import 'package:carea/app/common/component/custom_button.dart';
import 'package:carea/app/common/component/sentence_card.dart';
import 'package:carea/app/common/component/toast_popup.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:carea/app/data/services/help_confirm_service.dart';
import 'package:carea/app/data/services/sample.dart';
import 'package:carea/app/data/services/stt_service.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SeekerConfirmScreen extends StatefulWidget {
  final String roomId;
  const SeekerConfirmScreen({super.key, required this.roomId});

  @override
  State<SeekerConfirmScreen> createState() => _SeekerConfirmScreenState();
}

class _SeekerConfirmScreenState extends State<SeekerConfirmScreen> {
  late HelpConfirmService helpConfirmService;
  String receivedSentence = '아직 문장이 도착하지 않았어요.';
  final SttService _sttService = SttService();
  String recognizedSentence = '아직 녹음한 문장이 없어요.';
  bool isRecognizing = false;
  bool isRecognizeFinished = false;

  @override
  void initState() {
    super.initState();
    helpConfirmService = HelpConfirmService();
    helpConfirmService.initializeWebsocket(widget.roomId);
    // onResponse 콜백 설정
    helpConfirmService.onOtherResponse = (String sentence) {
      careaToast(toastMsg: '문장 수신이 완료되었습니다.');
      setState(() {
        receivedSentence = sentence;
      });
    };

    // STT 기능
    _sttService.onRecognizingStarted = () {
      setState(() {
        isRecognizing = true;
      });
    };
    _sttService.onResultReceived = (resultText, recognizeFinished) {
      setState(() {
        recognizedSentence = resultText;
        // 테스트용 STT 결과 문장 출력
        print(recognizedSentence);
        // 음성 종료 후
        if (recognizeFinished) {
          isRecognizeFinished = true;
        }
      });
    };
    _sttService.onRecognizingStopped = () {
      setState(() {
        isRecognizing = false;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            helpConfirmService.dispose();
            Navigator.pop(context);
          },
        ),
        title: const Text('도움 인증'),
        centerTitle: true,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: getScreenHeight(context) * 0.05),
            const Text(
              '인증 문장',
              style: screenContentTitleTextStyle,
            ),
            const SizedBox(height: 12),
            SentenceCard(
              text: receivedSentence,
              bgcolor: AppColors.faintGray,
              textStyle: sentenceTextStyle,
            ),
            SizedBox(height: getScreenHeight(context) * 0.05),
            const Text(
              '인증 문장을 녹음해주세요 💬',
              style: screenContentTitleTextStyle,
            ),
            const SizedBox(height: 12),
            SentenceCard(
              text: recognizedSentence,
              bgcolor: AppColors.faintGray,
              textStyle: sentenceTextStyle,
            ),
            SizedBox(height: getScreenHeight(context) * 0.10),
            recordingIndicator(),
            Center(
              child: VoiceRecordButton(
                onPressed: toggleRecording,
                isRecognizing: isRecognizing,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> toggleRecording() async {
    print(isRecognizing);

    if (isRecognizing) {
      // 녹음 중지
      _sttService.stopRecording();
      setState(() {
        recognizedSentence = '인증 확인 중이에요..👀';
        isRecognizeFinished = true;
        // TODO: 결과 비교 후 Dialog 띄우는 로직 추가
      });
    } else {
      setState(() {
        recognizedSentence = '녹음 중이에요...';
        isRecognizing = true;
      });
      // 녹음 시작
      _sttService.streamingRecognize();
    }
  }

  Widget recordingIndicator() {
    return isRecognizing
        ? Lottie.asset(
            'asset/lottie/recording.json',
            width: 100,
            height: 100,
          )
        : const SizedBox(
            width: 100,
            height: 100,
          );
  }
}
