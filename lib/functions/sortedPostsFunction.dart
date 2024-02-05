import 'dart:core';

import 'package:news_application/data/newsPost.dart';

List<NewsPost> postsSort(List<NewsPost> dataList, String sortedBy) {
  List<NewsPost> copyDataList = [...dataList];
  if (sortedBy == "Title") {
    copyDataList.sort((first, second) => first.title.compareTo(second.title));
  } else if (sortedBy == "Author") {
    copyDataList.sort((first, second) => first.author.compareTo(second.author));
  } else if (sortedBy == "Date") {
    copyDataList.sort((first, second) {
      DateTime firstCompareDate = DateTime.parse(
          first.publishedAt.replaceAll("T", " ").replaceAll("Z", ""));
      DateTime secondCompareDate = DateTime.parse(
          second.publishedAt.replaceAll("T", " ").replaceAll("Z", ""));
      return firstCompareDate.compareTo(secondCompareDate);
    });
  }
  return copyDataList;
}
