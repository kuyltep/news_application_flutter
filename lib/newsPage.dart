import 'package:flutter/material.dart';
import 'package:news_application/fetchNewsData.dart';
import 'package:news_application/newsPost.dart';

import 'newsTile.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isOpen = false;
  final controller = ScrollController();
  List<NewsPost> newsPostsList = [];
  List<NewsPost> searchedList = [];
  List<NewsPost> newNewsPosts = [];
  int pageNumber = 1;
  @override
  void didChangeDependencies() {
    setState(() {
      getNewsList(pageNumber).then((value) => {newsPostsList = value});
      searchedList = newsPostsList;
    });
    super.didChangeDependencies();
  }

  @override
  // void initState() {
  //   getNewsList(pageNumber).then((value) => {newsPostsList = value});
  //   searchedList = newsPostsList;
  //   controller.addListener(() {
  //     if (controller.position.maxScrollExtent == controller.offset) {
  //       pageNumber++;
  //       setState(() {
  //         getNewsList(pageNumber).then((value) => newNewsPosts = value);
  //         newsPostsList.addAll(newNewsPosts);
  //       });
  //     }
  //   });
  //   super.initState();
  // }

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          searchedList = [];
          for (int i = 0; i < newsPostsList.length; i++) {
            final NewsPost newsPost = newsPostsList[i];
            final String newsTitle = newsPost.title;
            if (newsTitle.toUpperCase().contains(s.toUpperCase())) {
              searchedList.add(newsPost);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search...',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade600,
          title: !isOpen
              ? Text(
                  "News",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              : _searchTextField(),
          actions: [
            !isOpen
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isOpen = !isOpen;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isOpen = !isOpen;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ))
          ],
        ),
        body: RefreshIndicator(
            color: Colors.blue,
            backgroundColor: Colors.white,
            strokeWidth: 2.0,
            onRefresh: () {
              setState(() {
                pageNumber = 1;
                getNewsList(pageNumber).then((value) => newsPostsList = value);
              });
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            child: !isOpen
                ? ListView.separated(
                    controller: controller,
                    // padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Colors.blue),
                    itemCount: newsPostsList.length + 1,
                    itemBuilder: ((context, index) {
                      if (index < newsPostsList.length) {
                        final NewsPost newsPost = newsPostsList[index];
                        return NewsTile(newsPost: newsPost);
                      }
                      //else {
                      //   return const Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 32),
                      //     child: Center(
                      //       child: CircularProgressIndicator(
                      //           color: Colors.blue),
                      //     ),
                      //   );
                      // }
                    }))
                : ListView.separated(
                    // padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Colors.blue),
                    itemCount: searchedList.length,
                    itemBuilder: ((context, index) {
                      final NewsPost newsPost = searchedList[index];
                      return NewsTile(newsPost: newsPost);
                    }))));
  }
}
