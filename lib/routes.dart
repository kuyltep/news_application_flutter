import 'package:news_application/newsPage.dart';
import 'package:news_application/oneNewsPage.dart';

final routes = {
  "/": (context) => const NewsPage(),
  "/news": (context) => const OneNewsPage(),
};
