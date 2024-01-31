import 'package:dio/dio.dart';
import 'newsPost.dart';

Future<List<NewsPost>> getNewsList(int page) async {
  final response = await Dio().get(
      "https://newsapi.org/v2/everything?q=apple&from=2024-01-29&to=2024-01-29&pageSize=15&page=$page&sortBy=popularity&apiKey=3b9fa1a3902b46e99eff220dfa863836");
  final data = response.data as Map<String, dynamic>;
  final newsData = data["articles"] as List;
  List<NewsPost> newsPostsList = [];
  for (var element in newsData) {
    final String sourceName = element["source"]["name"];
    final String title = element["title"];
    final String url = element["url"];
    final String author = element["author"];
    final dynamic imageUrl = element["urlToImage"];
    final String content = element["content"];
    final String publishedAt = element["publishedAt"];

    newsPostsList.add(NewsPost(
        sourceName: sourceName,
        title: title,
        author: author,
        url: url,
        imageUrl: imageUrl,
        content: content,
        publishedAt: publishedAt));
  }
  return newsPostsList;
}
