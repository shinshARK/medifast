import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rumah_sakit/models/artikel_models.dart';
import 'package:rumah_sakit/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumah_sakit/models/user_models.dart';

class ArticleRepository {

  final SharedPreferences sharedPreferences;

  ArticleRepository(this.sharedPreferences);

  Future<List<Article>> fetchArticle() async {

    final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'] ;
    print(token);
    final response = await http.get(
      Uri.parse('http://localhost:8000/articles/'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonResponse = json.decode(response.body);
      // List<dynamic> articleList = jsonResponse['article'];
      return jsonResponse.map((data) => Article.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load article');
    }

  }

  Future<Article> fetchArticleById(int id) async {
    final token = jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'] ;
    final response = await http.get(
      Uri.parse('http://localhost:8000/articles/$id'),
      headers: {
        'Authorization': 'Bearer $token'
      }
    );
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load article');
    }
  }
}
