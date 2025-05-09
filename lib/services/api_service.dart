import 'package:bharatnxt_article_app/models/article.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService{
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<Article>> fetchArticles() async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      List jsonList = json.decode(response.body);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load articles');
    }

  }
}