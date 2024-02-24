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
}
