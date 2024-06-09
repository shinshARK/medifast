// article_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rumah_sakit/models/artikel_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleRepository {
  final SharedPreferences sharedPreferences;

  ArticleRepository(this.sharedPreferences);

  Future<List<Article>> fetchArticles() async {
    final token =
        jsonDecode(sharedPreferences.getString('tokens') ?? '')['access_token'];
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/articles/'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Article.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
