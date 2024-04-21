import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rumah_sakit/models/artikel_models.dart';

// ignore: camel_case_types
class detailArtikel2 extends StatefulWidget {

  final Article articles;
  final String judulpage;

  const detailArtikel2({super.key, required this.articles,required this.judulpage});
  @override
  // ignore: library_private_types_in_public_api
  _detailArtikel2State createState() => _detailArtikel2State();
}

// ignore: camel_case_types
class _detailArtikel2State extends State<detailArtikel2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.judulpage,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: _judulArtikel(),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromRGBO(102, 121, 105, 30)),
                  child: Image.asset('assets/images/${widget.articles.photo}')),
              _contentArtikel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _judulArtikel() {
    return Text(
      widget.articles.title,
      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _contentArtikel() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        widget.articles.content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
