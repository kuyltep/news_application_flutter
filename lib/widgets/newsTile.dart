import 'package:flutter/material.dart';
import 'package:news_application/data/newsPost.dart';
import 'package:news_application/functions/parseDateFunctions.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../pages/oneNewsPage.dart';

class NewsTile extends StatefulWidget {
  const NewsTile({super.key, required this.newsPost});
  final NewsPost newsPost;
  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  late String activeElement;
  @override
  void initState() {
    setState(() {
      activeElement = "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: widget.newsPost.imageUrl != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Image.network(
                          widget.newsPost.imageUrl,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        width: 300,
                        height: 150,
                        child: Center(
                          child: Text("News without image",
                              style: TextStyle(color: Colors.grey.shade800)),
                        )),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.newsPost.title.length > 40
                          ? "${widget.newsPost.title.substring(0, 40)}..."
                          : widget.newsPost.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: const Icon(Icons.people)),
                          Text(
                            parseAuthorName(widget.newsPost.author),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
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
                          parseDateAndTime(widget.newsPost.publishedAt),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade800),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, "/news",
                                arguments: widget.newsPost);
                          },
                          label: const Text("News page"),
                          icon: const Icon(Icons.newspaper),
                        ),
                        Link(
                          target: LinkTarget.self,
                          uri: Uri.parse(widget.newsPost.url),
                          builder: (context, openLink) => TextButton.icon(
                            onPressed: openLink,
                            label: const Text("Website"),
                            icon: const Icon(Icons.web),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Row(
                            children: [
                              Visibility(
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: activeElement == "thumbDown",
                                  child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInOutBack,
                                      opacity:
                                          activeElement == "thumbDown" ? 1 : 0,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              activeElement = "";
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.thumb_down_alt_outlined,
                                            color: Colors.red,
                                          )))),
                              Visibility(
                                  visible: activeElement != "thumbDown",
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: AnimatedOpacity(
                                      opacity:
                                          activeElement != "thumbDown" ? 1 : 0,
                                      curve: Curves.easeInOutBack,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              activeElement = "thumbDown";
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.thumb_down_alt_outlined)))),
                            ],
                          )),
                          Container(
                            child: Row(children: [
                              Visibility(
                                  visible: activeElement == "smileBad"
                                      ? true
                                      : false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: AnimatedOpacity(
                                    opacity:
                                        activeElement == "smileBad" ? 1 : 0,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.bounceInOut,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            activeElement = "";
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.sentiment_dissatisfied_sharp,
                                          color: Colors.red,
                                        )),
                                  )),
                              Visibility(
                                  visible: activeElement != "smileBad"
                                      ? true
                                      : false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: AnimatedOpacity(
                                    opacity:
                                        activeElement != "smileBad" ? 1 : 0,
                                    curve: Curves.bounceInOut,
                                    duration: const Duration(milliseconds: 600),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            activeElement = "smileBad";
                                          });
                                        },
                                        icon: const Icon(Icons
                                            .sentiment_dissatisfied_sharp)),
                                  ))
                            ]),
                          ),
                          Container(
                              child: Row(
                            children: [
                              Visibility(
                                  visible: activeElement == "smileGood"
                                      ? true
                                      : false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: AnimatedOpacity(
                                    opacity:
                                        activeElement == "smileGood" ? 1 : 0,
                                    curve: Curves.decelerate,
                                    duration: const Duration(milliseconds: 700),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            activeElement = "";
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.sentiment_satisfied_alt,
                                          color: Colors.green,
                                        )),
                                  )),
                              Visibility(
                                visible:
                                    activeElement != "smileGood" ? true : false,
                                child: AnimatedOpacity(
                                    opacity:
                                        activeElement != "smileGood" ? 1 : 0,
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.decelerate,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            activeElement = "smileGood";
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.sentiment_satisfied_alt))),
                              )
                            ],
                          )),
                          Container(
                              child: Row(
                            children: [
                              Visibility(
                                visible:
                                    activeElement == "thumbUp" ? true : false,
                                child: AnimatedOpacity(
                                  opacity: activeElement == "thumbUp" ? 1 : 0,
                                  curve: Curves.elasticInOut,
                                  duration: const Duration(milliseconds: 800),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          activeElement = "";
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.thumb_up_outlined,
                                        color: Colors.green,
                                      )),
                                ),
                              ),
                              Visibility(
                                  visible:
                                      activeElement != "thumbUp" ? true : false,
                                  child: AnimatedOpacity(
                                    opacity: activeElement != "thumbUp" ? 1 : 0,
                                    duration: const Duration(milliseconds: 800),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            activeElement = "thumbUp";
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.thumb_up_outlined)),
                                  ))
                            ],
                          ))
                        ]),
                  )
                ],
              )
            ],
          )),
    );
  }
}

// Route _createRoute(widget.NewsPost newsPost) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>
//         OneNewsPage(newsPost: newsPost),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const curve = Curves.ease;
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       final tween = Tween(begin: begin, end: end);
//       final curvedAnimation = CurvedAnimation(
//         parent: animation,
//         curve: curve,
//       );

//       return SlideTransition(
//         position: tween.animate(curvedAnimation),
//         child: child,
//       );
//     },
//   );
// }
