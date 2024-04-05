import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailPertemuan extends StatefulWidget {
  const DetailPertemuan({Key? key}) : super(key: key);

  @override
  _DetailPertemuanState createState() => _DetailPertemuanState();
}

class _DetailPertemuanState extends State<DetailPertemuan> {
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
          const SizedBox(height: 25), // Menambahkan ruang kosong
          Container(
            padding: const EdgeInsets.only(
                left: 30.0), // Menambahkan ruang di sebelah kiri
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
              children: [
                Text("Nomor Antrian: 12"),
                Text("Ruanggan: Gedung A, Lantai 3, Ruangan 305"),
              ],
            ),
          ),
          const SizedBox(height: 20), // Menambahkan ruang kosong
          Image.asset('assets/images/qrcode.png'), // Menambahkan gambar
        ],
      ),
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
