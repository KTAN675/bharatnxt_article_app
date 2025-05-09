import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleProvider with ChangeNotifier {
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  List<int> _favoriteIds = [];
  bool _isLoading = false;
  String _error = '';

  List<Article> get articles => _filteredArticles;
  List<Article> get favorites => _articles.where((a) => _favoriteIds.contains(a.id)).toList();
  bool get isLoading => _isLoading;
  String get error => _error;

  ArticleProvider() {
    fetchArticles();
    loadFavorites();
  }

  get updateSearchQuery => null;

  Future<void> fetchArticles() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body);
        _articles = jsonData.map((e) => Article.fromJson(e)).toList();
        _filteredArticles = _articles;
      } else {
        _error = 'Failed to load articles';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredArticles = _articles;
    } else {
      _filteredArticles = _articles
          .where((a) =>
      a.title.toLowerCase().contains(query.toLowerCase()) ||
          a.body.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void toggleFavorite(int id) async {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favoriteIds.map((e) => e.toString()).toList());
  }

  bool isFavorite(int id) => _favoriteIds.contains(id);

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    _favoriteIds = favList.map((e) => int.parse(e)).toList();
    notifyListeners();
  }
}
