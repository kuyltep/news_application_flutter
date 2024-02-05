import 'package:intl/intl.dart';

String parseDateAndTime(String date) {
  String dateString = date.substring(0, 10);
  String timeString = date.substring(10, date.length);
  dateString = dateString.split("-").reversed.join(".");
  String finalString = dateString + timeString;
  return "Published ${finalString.replaceAll("T", " at ").replaceAll("Z", "")}";
}

String parseAuthorName(String name) {
  return name
      .replaceAll(RegExp(r"\w+@[a-zA-Z]+\.[a-z]+"), "")
      .replaceAll(RegExp(r"[\(\)']+"), "");
}

String madeNewsTitleWithTwoWords(String title) {
  final arrayWithWords = title.split(" ");
  return "${arrayWithWords[0]} ${arrayWithWords[1]} ${arrayWithWords[2]}";
}

String madeNowSttingDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat("yyyy-mm-dd").format(now);
  return formattedDate;
}
