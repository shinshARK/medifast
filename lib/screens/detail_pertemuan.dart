import 'dart:async';
import 'package:flutter/material.dart';

class DetailPertemuan extends StatefulWidget {
  const DetailPertemuan({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailPertemuanState createState() => _DetailPertemuanState();
}

class _DetailPertemuanState extends State<DetailPertemuan> {
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        _showSuccessMessage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _profil(context),
          const Text(
            "Dr. Eki Rakhmah Z., Sp.A",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text("Dokter Anak"),
          const SizedBox(height: 20), // Menambahkan ruang kosong
          Image.asset('assets/images/qrcode.png'), // Menambahkan gambar
          const SizedBox(height: 20), // Menambahkan ruang kosong
          Container(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0), // Menambahkan ruang di sebelah kiri
            child: Center(
              // Widget Center
              child:
                  _showSuccessMessage ? _successMessage() : _initialMessage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _initialMessage() {
    return const Text(
      "Silahkan scan QR-Code untuk melakukan Registrasi Ulang.",
      textAlign: TextAlign.center, // Teks rata tengah
      style: TextStyle(fontWeight: FontWeight.bold), // Teks tebal
    );
  }

  Widget _successMessage() {
    return Column(
      children: [
        const Text(
          "Registrasi Ulang Berhasil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1BAC4B), // Add this line
          ),
        ),
        const Text(
          "Nomor Antrian dan Ruangan dapat dilihat pada kolom Detail.",
          textAlign: TextAlign.center, // Add this line
          style: TextStyle(
            fontSize: 12.0, // Change this value as needed
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF87CBC6), 
                ),
                onPressed: () {
                  // Define what happens when the button is pressed
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons
                          .arrow_circle_up_outlined, 
                      color: Colors
                          .black, 
                    ),
                    SizedBox(
                      width:
                          5, 
                    ),
                    Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors
                            .black, 
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(55.0),
              decoration: BoxDecoration(
                color: const Color(0xFF87CBC6), // Background color
                borderRadius: BorderRadius.circular(15.0), // Corner radius
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Nomor Antrian :"),
                  Text(
                    "12",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Gedung A, Lantai :"),
                  Text(
                    "Ruangan : Ruangan 305",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Anda diarahkan untuk melakukan"),
                  Text("pengecekan pada Nurse Station."),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Stack _profil(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 144.0,
            height: 144.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white.withOpacity(0.0),
                child: const Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/dokter_1.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
