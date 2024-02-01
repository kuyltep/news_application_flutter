import 'package:flutter/material.dart';
import 'package:news_application/newsPost.dart';
import 'package:news_application/parseDateFunctions.dart';

class OneNewsPage extends StatefulWidget {
  const OneNewsPage({super.key});
  @override
  State<OneNewsPage> createState() => _OneNewsPageState();
}

class _OneNewsPageState extends State<OneNewsPage> {
  @override
  NewsPost? newsPost;
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    newsPost = args as NewsPost;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          backgroundColor: Colors.blue.shade600,
          title: Text(madeNewsTitleWithTwoWords(newsPost!.title),
              style: Theme.of(context).textTheme.titleMedium)),
    );
  }
}
