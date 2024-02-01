String parseDateAndTime(String date) {
  return "Published ${date.replaceAll("T", " at ").replaceAll("Z", "")}";
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
