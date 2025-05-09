import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import 'favourite.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: provider.search,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.error.isNotEmpty
                ? Center(child: Text(provider.error))
                : RefreshIndicator(
              onRefresh: provider.fetchArticles,
              child: ListView.builder(
                itemCount: provider.articles.length,
                itemBuilder: (context, index) {
                  final article = provider.articles[index];
                  return ArticleCard(article: article);
                },
              ),
            ),
          ),


      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Articles'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
          }
        },
      ),
    );
  }
}
