import 'package:dio/dio.dart';

import 'newsPost.dart';

Future<List<NewsPost>> getCoinsList() async {
  final response = await Dio().get(
      "https://newsapi.org/v2/everything?q=apple&from=2024-01-29&to=2024-01-29&sortBy=popularity&apiKey=3b9fa1a3902b46e99eff220dfa863836");
  final data = response.data.articles as Map<String, dynamic>;
  final newsPostsList = data.entries.map((e) {
    late String sourceName;
    late String title;
    late String url;
    late String author;
    late String imageUrl;
    late String content;
    late String publishedAt;
    switch (e.key) {
      case "source":
        sourceName = e.value["name"];
        break;
      case "author":
        author = e.value;
        break;
      case "title":
        title = e.value;
        break;
      case "url":
        url = e.value;
        break;
      case "imageUrl":
        imageUrl = e.value;
        break;
      case "content":
        content = e.value;
        break;
      case "publishedAt":
        publishedAt = e.value;
        break;
    }
    return NewsPost(
        sourceName: sourceName,
        title: title,
        author: author,
        url: url,
        imageUrl: imageUrl,
        content: content,
        publishedAt: publishedAt);
  }).toList();
  return newsPostsList;
}
