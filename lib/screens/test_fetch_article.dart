import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import DateFormat
import 'package:rumah_sakit/models/artikel_models.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Fetch data from the API
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/articles'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> jsonResponse = json.decode(response.body);
      // print(jsonResponse);

      // Convert each JSON object to an Article object
      List<Article> parsedArticles = jsonResponse.map((articleJson) {
        return Article.fromJson(articleJson);
      }).toList();

      print(parsedArticles);

      // Update the state with the parsed articles
      setState(() {
        articles = parsedArticles;
      });
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Page'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          // Display each article in a ListTile
          return ListTile(
            title: Text(articles[index].title),
            subtitle: Text(articles[index].content),
            // Format and display the datetime
            trailing: Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(articles[index].createdat)),
          );
        },
      ),
    );
  }
}
