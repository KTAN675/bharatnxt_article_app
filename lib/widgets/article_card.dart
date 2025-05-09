import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';
import '../screens/detail_screen.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Card(
      child: ListTile(
        title: Text(article.title,style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(article.body.length > 100
            ? '${article.body.substring(0, 100)}...'
            : article.body),
        trailing: IconButton(
          icon: Icon(
            provider.isFavorite(article.id) ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () => provider.toggleFavorite(article.id),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
          );
        },
      ),
    );
  }
}

