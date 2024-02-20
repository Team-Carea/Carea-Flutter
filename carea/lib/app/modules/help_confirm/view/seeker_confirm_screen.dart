import 'package:carea/app/common/component/sentence_card.dart';
import 'package:carea/app/common/component/voice_record_button.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SeekerConfirmScreen extends StatefulWidget {
  const SeekerConfirmScreen({super.key});

  @override
  State<SeekerConfirmScreen> createState() => _SeekerConfirmScreenState();
}

class _SeekerConfirmScreenState extends State<SeekerConfirmScreen> {
  bool isRecording = false; // 부모 위젯에서 녹음 상태 관리

  void handleRecordingStateChanged(bool recordingState) {
    setState(() {
      isRecording = recordingState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
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
            SizedBox(height: getScreenHeight(context) * 0.03),
            const Text(
              '인증 문장',
              style: screenContentTitleTextStyle,
            ),
            const SizedBox(height: 12),
            const SentenceCard(
              text: '아직 문장이 도착하지 않았어요.',
              bgcolor: AppColors.faintGray,
              textStyle: sentenceTextStyle,
            ),
            SizedBox(height: getScreenHeight(context) * 0.05),
            const Text(
              '인증 문장을 녹음해주세요 💬',
              style: screenContentTitleTextStyle,
            ),
            const SizedBox(height: 12),
            const SentenceCard(
              text: '아직 녹음한 문장이 없어요.',
              bgcolor: AppColors.faintGray,
              textStyle: sentenceTextStyle,
            ),
            SizedBox(height: getScreenHeight(context) * 0.16),
            recordingIndicator(),
            Center(
              child: VoiceRecordButton(
                onPressed: () {
                  // TODO: 녹음 전/중/후 상태에 따른 UI 구현
                },
                onRecordingStateChanged:
                    handleRecordingStateChanged, // 상태 변경 콜백 전달
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recordingIndicator() {
    return isRecording
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
