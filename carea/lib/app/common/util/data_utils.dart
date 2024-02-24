import 'package:carea/app/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class DataUtils {
  static String getTimeFromDateTime({required DateTime dateTime}) {
    return '${getTimeFormat(dateTime.hour)}:${getTimeFormat(dateTime.minute)}';
  }

  static String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }

  static String getFormattedText(String text) {
    if (text.length > 20) {
      List<String> splitText = [];
      for (int i = 0; i < text.length; i += 20) {
        int end = (i + 20 < text.length) ? i + 20 : text.length;
        splitText.add(text.substring(i, end));
      }
      // 분할된 문자열을 줄바꿈 문자로 연결
      text = splitText.join('\n');
    }
    return text;
  }

  static bool compareTwoSentences(String s1, String s2) {
    // 정규 표현식을 사용하여 구두점과 공백 제거
    String normalize(String sentence) {
      return sentence.replaceAll(RegExp(r'[^\w]'), '').toLowerCase();
    }

    // 정규화된 문자열 비교
    return normalize(s1) == normalize(s2);
  }

  static bool compareTwoKoreanSentences(String s1, String s2) {
    String clean(String input) {
      return input.replaceAll(RegExp('[^가-힣0-9]'), '');
    }

    return clean(s1) == clean(s2);
  }

  static List<TextSpan> markDifferentWord(String s1, String s2) {
    List<String> words1 = s1.split(' ');
    List<String> words2 = s2.split(' ');
    List<TextSpan> spans = [];

    int maxLength =
        words1.length > words2.length ? words1.length : words2.length;

    for (int i = 0; i < maxLength; i++) {
      if (i < words1.length && (i >= words2.length || words1[i] != words2[i])) {
        spans.add(TextSpan(
            text: '${words1[i]} ',
            style: const TextStyle(
                color: AppColors.redAccentColor,
                fontSize: 17,
                fontWeight: FontWeight.w600)));
      } else if (i < words1.length) {
        spans.add(TextSpan(
            text: '${words1[i]} ',
            style: const TextStyle(
                color: AppColors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500)));
      }
    }

    return spans;
  }
}
