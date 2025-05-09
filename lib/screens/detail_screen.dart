import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/article.dart';
import '../providers/article_provider.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        actions: [
          IconButton(
            icon: Icon(
              provider.isFavorite(article.id) ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => provider.toggleFavorite(article.id),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(article.body),
      ),
    );
  }
}
