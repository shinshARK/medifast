import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class detailArtikel2 extends StatefulWidget {
  const detailArtikel2({super.key});

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
        title: const Text('Kesehatan',
            style: TextStyle(fontWeight: FontWeight.w700)),
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color.fromRGBO(102, 121, 105, 30)),
                  child: Image.asset('assets/images/artikel2.png')),
              _contentArtikel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _judulArtikel() {
    return Text(
      "4 Rekomendasi Obat Maag yang Ampuh",
      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _contentArtikel() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        "1. Mylanta: Mylanta adalah salah satu obat maag yang bagus dan banyak dikenal masyarakat. Obat ini mengandung kombinasi dari magnesium hidroksida dan aluminium hidroksida yang dapat meredakan sakit maag.\n"
        "2. Promag: Promag juga merupakan pilihan obat maag yang bagus dan mudah didapatkan di apotek maupun warung. Obat ini juga mengandung magnesium hidroksida dan aluminium hidroksida.\n"
        "3. Polysilane: Polysilane adalah obat maag yang dapat membantu mengatasi masalah maag dan gangguan pencernaan lain seperti perut kembung dan rasa tidak nyaman di perut.\n"
        "4. Polycrol Forte: Polycrol Forte adalah obat maag cair yang mengandung aluminium hidroksida, magnesium hidroksida, dan methylpolysiloxane. Obat ini efektif untuk mengobati gangguan pada saluran pencernaan seperti gastritis, perut kembung, maag, hiatus hernia, tukak lambung, dan usus duabelas jari.",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
