import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:rumah_sakit/screens/detailArtikel2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import DateFormat
import 'package:rumah_sakit/models/artikel_models.dart';

// ignore: must_be_immutable, camel_case_types
class halamanArtikel extends StatefulWidget {
  const halamanArtikel({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _halamanArtikelState createState() => _halamanArtikelState();
}

// ignore: camel_case_types
class _halamanArtikelState extends State<halamanArtikel> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    // fetchData();
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
      bottomNavigationBar: const BottomNavigasiBar(inputan: 3),
      appBar: AppBar(
        title: const Text(
          'Artikel',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _artikel1(),
              Container(
                height: 172,
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _artikel1_Padding(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20.0,
                  ),
                  itemCount: 2,
                ),
              ),
              _artikel2(),
              Container(
                height: 172,
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _artikel2_Padding(index),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20.0,
                  ),
                  itemCount: articles.length,
                ),
              ),
              _artikel3(),
              Container(
                height: 172,
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _artikel3_Padding(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20.0,
                  ),
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector _artikel1_Padding() {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        width: 360.0,
        height: 172.0,
        margin: const EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromRGBO(102, 121, 105, 30)),
        child: Row(
          children: [
            Container(
              width: 178.0,
              height: 162.0,
              padding: const EdgeInsets.only(left: 20, top: 50, bottom: 10),
              child: const Text('Atur Pola Makan dengan Teratur',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ),
            Container(
              width: 180.0,
              height: 180.0,
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/artikel1.png'),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector _artikel2_Padding(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => detailArtikel2(articles: articles[index],judulpage: "Kesehatan",)),
        );
      },
      child: Container(
        width: 360.0,
        height: 172.0,
        margin: const EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromRGBO(102, 121, 105, 30)),
        child: Row(
          children: [
            Container(
              width: 180.0,
              height: 140.0,
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/${articles[index].photo}'),
            ),
            Container(
              width: 178.0,
              height: 162.0,
              padding: const EdgeInsets.only(left: 20, top: 40, bottom: 10),
              child: Text(articles[index].title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector _artikel3_Padding() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 360.0,
        height: 172.0,
        margin: const EdgeInsets.only(bottom: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromRGBO(102, 121, 105, 30)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: 178.0,
                height: 172.0,
                padding: const EdgeInsets.only(left: 20, top: 50, bottom: 10),
                child: const Text('Kenali Penyebab Perut Melilit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
              ),
            ),
            Expanded(
              child: Container(
                width: 210.0,
                height: 172.0,
                alignment: Alignment.centerRight,
                child: Image.asset('assets/images/artikel3.png'),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row _artikel1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 30),
          child: Text(
            "Artikel terkini\n",
            style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.w600, // Semi-bold
            ),
          ),
        ),
      ],
    );
  }

  Row _artikel2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 1),
          child: Text(
            "Kesehatan\n",
            style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.w600, // Semi-bold
            ),
          ),
        ),
      ],
    );
  }

  Row _artikel3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 1),
          child: Text(
            "Pola Hidup\n",
            style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.w600, // Semi-bold
            ),
          ),
        ),
      ],
    );
  }
}
