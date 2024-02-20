import 'package:carea/app/common/component/custom_button.dart';
import 'package:carea/app/common/component/notice_dialog.dart';
import 'package:carea/app/common/component/sentence_card.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:flutter/material.dart';

class HelperConfirmScreen extends StatefulWidget {
  const HelperConfirmScreen({super.key});

  @override
  State<HelperConfirmScreen> createState() => _HelperConfirmScreenState();
}

class _HelperConfirmScreenState extends State<HelperConfirmScreen> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '인증 문장 생성',
                  style: screenContentTitleTextStyle,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      '생성하기',
                      style: screenContentTitleBlueTextStyle,
                    )),
              ],
            ),
            const SentenceCard(
              text: '아직 생성된 문장이 없습니다.',
              bgcolor: AppColors.faintGray,
              textStyle: sentenceTextStyle,
            ),
            SizedBox(height: getScreenHeight(context) * 0.05),
            const Text(
              '인증 문장을 보내주세요 💬',
              style: screenContentTitleTextStyle,
            ),
            const SizedBox(height: 12),
            CustomElevatedButton(
              text: '전송하기',
              screenRoute: () => showLevelUpDialog(context),
              icon: Icons.send,
            )
          ],
        ),
      ),
    );
  }
}