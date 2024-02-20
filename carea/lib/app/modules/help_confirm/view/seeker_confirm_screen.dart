import 'package:carea/app/common/component/custom_button.dart';
import 'package:carea/app/common/component/notice_dialog.dart';
import 'package:carea/app/common/component/sentence_card.dart';
import 'package:carea/app/common/component/voice_record_button.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:flutter/material.dart';

class SeekerConfirmScreen extends StatefulWidget {
  const SeekerConfirmScreen({super.key});

  @override
  State<SeekerConfirmScreen> createState() => _SeekerConfirmScreenState();
}

class _SeekerConfirmScreenState extends State<SeekerConfirmScreen> {
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
            SizedBox(height: getScreenHeight(context) * 0.23),
            Center(child: VoiceRecordButton(onPressed: () {
              showFailureConfirmDialog(context);
            }))
          ],
        ),
      ),
    );
  }
}
