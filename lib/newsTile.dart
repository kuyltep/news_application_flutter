import 'package:flutter/material.dart';
import 'package:news_application/newsPost.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.newsPost});
  final NewsPost newsPost;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network(
          newsPost.imageUrl,
          width: 70,
          height: 70,
        ),
        title: Text(
          newsPost.title.length > 40
              ? "${newsPost.title.substring(0, 40)}..."
              : newsPost.title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle:
            Text(newsPost.author, style: Theme.of(context).textTheme.bodySmall),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.blue,
        ),
        onTap: () {
          Navigator.of(context).pushNamed("/news", arguments: newsPost);
        });
  }
}
