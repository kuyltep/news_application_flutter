import 'package:flutter/material.dart';

class ReactionSection extends StatefulWidget {
  const ReactionSection({super.key});

  @override
  State<ReactionSection> createState() => _ReactionSection();
}

class _ReactionSection extends State<ReactionSection> {
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
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: Row(
        children: [
          Visibility(
              maintainAnimation: true,
              maintainState: true,
              visible: activeElement == "thumbDown",
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutBack,
                  opacity: activeElement == "thumbDown" ? 1 : 0,
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
                  opacity: activeElement != "thumbDown" ? 1 : 0,
                  curve: Curves.easeInOutBack,
                  duration: const Duration(milliseconds: 400),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          activeElement = "thumbDown";
                        });
                      },
                      icon: const Icon(Icons.thumb_down_alt_outlined)))),
        ],
      )),
      Container(
        child: Row(children: [
          Visibility(
              visible: activeElement == "smileBad" ? true : false,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: activeElement == "smileBad" ? 1 : 0,
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
              visible: activeElement != "smileBad" ? true : false,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: activeElement != "smileBad" ? 1 : 0,
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 600),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        activeElement = "smileBad";
                      });
                    },
                    icon: const Icon(Icons.sentiment_dissatisfied_sharp)),
              ))
        ]),
      ),
      Container(
          child: Row(
        children: [
          Visibility(
              visible: activeElement == "smileGood" ? true : false,
              maintainAnimation: true,
              maintainState: true,
              child: AnimatedOpacity(
                opacity: activeElement == "smileGood" ? 1 : 0,
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
            visible: activeElement != "smileGood" ? true : false,
            child: AnimatedOpacity(
                opacity: activeElement != "smileGood" ? 1 : 0,
                duration: const Duration(milliseconds: 700),
                curve: Curves.decelerate,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        activeElement = "smileGood";
                      });
                    },
                    icon: const Icon(Icons.sentiment_satisfied_alt))),
          )
        ],
      )),
      Container(
          child: Row(
        children: [
          Visibility(
            visible: activeElement == "thumbUp" ? true : false,
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
              visible: activeElement != "thumbUp" ? true : false,
              child: AnimatedOpacity(
                opacity: activeElement != "thumbUp" ? 1 : 0,
                duration: const Duration(milliseconds: 800),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        activeElement = "thumbUp";
                      });
                    },
                    icon: const Icon(Icons.thumb_up_outlined)),
              ))
        ],
      ))
    ]);
  }
}
