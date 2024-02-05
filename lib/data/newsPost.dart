class NewsPost {
  const NewsPost(
      {required this.sourceName,
      required this.title,
      required this.author,
      required this.url,
      required this.imageUrl,
      required this.content,
      required this.publishedAt});
  final String sourceName;
  final String title;
  final String author;
  final String url;
  final dynamic imageUrl;
  final String content;
  final String publishedAt;
}
