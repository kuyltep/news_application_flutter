import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isOpen = false;

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        // setState(() {
        //   searchedList = [];
        //   for (int i = 0; i < initialList.length; i++) {
        //     final CryptoCoin coin = initialList[i];
        //     final String coinName = coin.name;
        //     if (coinName.contains(s.toUpperCase()) ||
        //         coinName.contains(s.toLowerCase())) {
        //       searchedList.add(coin);
        //     }
        //   }
        // });
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
          centerTitle: true,
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
        body: const Center());
  }
}
