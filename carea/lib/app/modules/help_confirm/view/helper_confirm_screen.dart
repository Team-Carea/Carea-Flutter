import 'package:carea/app/common/component/custom_button.dart';
import 'package:carea/app/common/component/sentence_card.dart';
import 'package:carea/app/common/component/toast_popup.dart';
import 'package:carea/app/common/const/app_colors.dart';
import 'package:carea/app/common/const/styles/app_text_style.dart';
import 'package:carea/app/common/layout/default_layout.dart';
import 'package:carea/app/common/util/data_utils.dart';
import 'package:carea/app/common/util/layout_utils.dart';
import 'package:carea/app/data/models/gemini_data_model.dart';
import 'package:carea/app/data/services/gemini_service.dart';
import 'package:carea/app/data/services/help_confirm_service.dart';
import 'package:flutter/material.dart';

class HelperConfirmScreen extends StatefulWidget {
  final String roomId;
  const HelperConfirmScreen({super.key, required this.roomId});

  @override
  State<HelperConfirmScreen> createState() => _HelperConfirmScreenState();
}

class _HelperConfirmScreenState extends State<HelperConfirmScreen> {
  late HelpConfirmWebSocketService helpConfirmService;
  String sentence = '아직 생성된 문장이 없습니다.';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    helpConfirmService = HelpConfirmWebSocketService();
    helpConfirmService.initializeWebsocket(widget.roomId);

    // onResponse 콜백 설정
    helpConfirmService.onMyResponse = () {
      careaToast(toastMsg: '전송이 완료되었습니다.');
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
            SizedBox(height: getScreenHeight(context) * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '인증 문장 생성',
                  style: screenContentTitleTextStyle,
                ),
                TextButton(
                    onPressed: updateSentence,
                    child: const Text(
                      '생성하기',
                      style: screenContentTitleBlueTextStyle,
                    )),
              ],
            ),
            SentenceCard(
              text: sentence,
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
              screenRoute: () {
                if (helpConfirmService.isInitialized) {
                  helpConfirmService
                      .sendSentence(sentence.replaceAll('\n', ''));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('웹소켓이 아직 초기화되지 않았습니다.'),
                    ),
                  );
                }
              },
              icon: Icons.send,
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateSentence() async {
    setState(() {
      isLoading = true;
      sentence = '생성 중이에요...';
    });

    try {
      GeminiResponseModel responseModel = await generateRandomSentence();
      String text = responseModel.text;
      text = DataUtils.getFormattedText(text);
      setState(() {
        sentence = text;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        sentence = '문장 생성에 실패했습니다.';
        isLoading = false;
      });
    }
  }
}
