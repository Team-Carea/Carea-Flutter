class DataUtils {
  static String getTimeFromDateTime({required DateTime dateTime}) {
    return '${getTimeFormat(dateTime.hour)}:${getTimeFormat(dateTime.minute)}';
  }

  static String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }
}
