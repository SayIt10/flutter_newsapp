import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences_app/model/news_model.dart';

class DetailNewsPage extends StatelessWidget {
  final Article article;

  const DetailNewsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail News'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.urlToImage ?? 'https://via.placeholder.com/600/121fa4'),
            const SizedBox(height: 10),
            Text(article.title ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(article.content ?? 'No description available'),
          ],
        ),
      ),
    );
  }
}