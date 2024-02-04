import 'package:flutter/material.dart';
import 'package:news_application/fetchNewsData.dart';
import 'package:news_application/newsPost.dart';
import 'package:news_application/oneNewsPage.dart';
import 'package:news_application/sortedPostsFunction.dart';

import 'newsTile.dart';

List<String> list = <String>['Default', 'Title', 'Author', 'Date'];

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
  List<NewsPost> sortedNewsPosts = [];
  int pageNumber = 1;
  bool isLoading = true;
  String dropdownValue = list.first;
  @override
  void didChangeDependencies() {
    setState(() {});
    getNewsList(pageNumber).then((value) {
      setState(() {
        newsPostsList = value;
        searchedList.addAll(newsPostsList);
        isLoading = false;
      });
    });
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        pageNumber++;
        getNewsList(pageNumber).then((value) {
          setState(() {
            newNewsPosts = value;
            newsPostsList.addAll(newNewsPosts);
          });
        });
      }
    });
    super.didChangeDependencies();
  }

  Widget _searchTextField() {
    return TextFormField(
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
      cursorColor: Colors.grey.shade500,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500)),
        hintText: 'Search...',
        hintStyle: const TextStyle(
          color: Colors.white60,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 31, 77, 116),
          title: !isOpen
              ? Text(
                  "News",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              : _searchTextField(),
          actions: [
            !isOpen
                ? Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: Text("Sorted by: ",
                              style: Theme.of(context).textTheme.titleSmall),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor:
                                  const Color.fromARGB(255, 31, 77, 116),
                              value: dropdownValue,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              elevation: 16,
                              style: const TextStyle(color: Colors.white),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                  sortedNewsPosts =
                                      postsSort(newsPostsList, value);
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isOpen = !isOpen;
                              });
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ],
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.blue,
              ))
            : RefreshIndicator(
                color: Colors.blue,
                backgroundColor: Colors.white,
                strokeWidth: 2.0,
                onRefresh: () {
                  setState(() {
                    dropdownValue = "Default";
                    pageNumber = 1;
                    getNewsList(pageNumber)
                        .then((value) => newsPostsList = value);
                  });
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: !isOpen && dropdownValue == "Default"
                    ? ListView.separated(
                        padding: const EdgeInsets.all(20),
                        controller: controller,
                        // padding: const EdgeInsets.all(10),
                        separatorBuilder: (context, index) =>
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                        itemCount: newsPostsList.length + 1,
                        itemBuilder: ((context, index) {
                          if (index < newsPostsList.length) {
                            final NewsPost newsPost = newsPostsList[index];
                            return NewsTile(newsPost: newsPost);
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 22),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.blue),
                              ),
                            );
                          }
                        }))
                    : !isOpen && dropdownValue != "Default"
                        ? ListView.separated(
                            padding: const EdgeInsets.all(20),
                            separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.only(bottom: 20)),
                            itemCount: sortedNewsPosts.length,
                            itemBuilder: ((context, index) {
                              final NewsPost newsPost = sortedNewsPosts[index];
                              return NewsTile(newsPost: newsPost);
                            }))
                        : ListView.separated(
                            padding: const EdgeInsets.all(20),
                            separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.only(bottom: 20)),
                            itemCount: searchedList.length,
                            itemBuilder: ((context, index) {
                              final NewsPost newsPost = searchedList[index];
                              return NewsTile(newsPost: newsPost);
                            }))));
  }
}
