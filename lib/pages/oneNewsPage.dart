import 'package:flutter/material.dart';
import 'package:news_application/data/newsPost.dart';
import 'package:news_application/functions/parseDateFunctions.dart';
import 'package:url_launcher/link.dart';

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
            backgroundColor: const Color.fromARGB(255, 31, 77, 116),
            title: Text(madeNewsTitleWithTwoWords(newsPost!.title),
                style: Theme.of(context).textTheme.titleMedium)),
        body: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color.fromARGB(255, 218, 218, 218),
                    Color.fromARGB(255, 215, 233, 246),
                    Color.fromARGB(255, 162, 162, 162),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                )),
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Center(
                child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  child: newsPost!.imageUrl != null
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            newsPost!.imageUrl,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          height: 150,
                          child: Center(
                            child: Text("News without image",
                                style: TextStyle(color: Colors.grey.shade800)),
                          )),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      newsPost!.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(Icons.people),
                    ),
                    Text(
                      parseAuthorName(newsPost!.author),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Text(
                          parseDateAndTime(newsPost!.publishedAt),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade800),
                        )
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                )
              ],
            ))));
  }
}
