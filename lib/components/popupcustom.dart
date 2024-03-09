import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:rumah_sakit/screens/halamanLogin.dart';

class PopupCustom extends StatefulWidget {
  
  final Function page1;
  final Function page2;

  // ignore: non_constant_identifier_names
  final int jumlah_tombol;
  final String notif; // berhasil atau gagal
  // ignore: non_constant_identifier_names
  final String judul_notif;
  // ignore: non_constant_identifier_names
  final String penjelasan_tambahan;
  // ignore: non_constant_identifier_names
  final String nama_tombol_1, nama_tombol_2;

  const PopupCustom({
    super.key,
    required this.page1,
    required this.page2,
    // ignore: non_constant_identifier_names
    required this.jumlah_tombol,
    required this.notif,
    // ignore: non_constant_identifier_names
    required this.judul_notif,
    // ignore: non_constant_identifier_names
    required this.penjelasan_tambahan,
    // ignore: non_constant_identifier_names
    required this.nama_tombol_1,
    // ignore: non_constant_identifier_names
    required this.nama_tombol_2,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PopupCustomState createState() => _PopupCustomState();
}

class _PopupCustomState extends State<PopupCustom> {
  late Function page1;
  late Function page2;

  // ignore: non_constant_identifier_names
  late int jumlah_tombol;
  late String notif;
  // ignore: non_constant_identifier_names
  late String judul_notif;
  // ignore: non_constant_identifier_names
  late String penjelasan_tambahan;
  // ignore: non_constant_identifier_names
  late String nama_tombol_1;
  // ignore: non_constant_identifier_names
  late String nama_tombol_2;

  @override
  void initState() {
    super.initState();
    page1 = widget.page1;
    page2 = widget.page2;
    jumlah_tombol = widget.jumlah_tombol;
    notif = widget.notif;
    judul_notif = widget.judul_notif;
    penjelasan_tambahan = widget.penjelasan_tambahan;
    nama_tombol_1 = widget.nama_tombol_1;
    nama_tombol_2 = widget.nama_tombol_2;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: penjelasan_tambahan != "" ? 500 : 400,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 142,
            height: 142,
            decoration: BoxDecoration(
              color: notif == "berhasil" ? const Color.fromARGB(255, 219, 231, 116) : Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(
               notif == "berhasil" ? Icons.verified_user : Icons.gpp_bad,
              size: 62,
              color: Colors.white,
            ),
          ),
          Container(
            
            width: 195,
            margin: const EdgeInsets.only(top: 30),
            child:  Text(
              judul_notif,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: notif == "berhasil" ? const Color.fromARGB(255, 219, 231, 116) : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          penjelasan_tambahan != "" ? Container(
            width: 300,
            margin: const EdgeInsets.only(top: 20),
            child:  Text(
              penjelasan_tambahan,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ) : const SizedBox(height: 0.001)
          ,
          GestureDetector(
            onTap: () {
              page1();
              // Navigator.pop(context);
              // Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const HalamanLogin()),
              // );
            },
            child: Container(
              width: 252,
              height: 52,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 135, 203, 198),
                  borderRadius: BorderRadius.circular(30)),
              child:  Text(
                nama_tombol_1,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          jumlah_tombol == 2 ? GestureDetector(
            onTap: () {
              page2();
              
            },
            child: Container(
              width: 252,
              height: 52,
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                 
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 135, 203, 198), // Warna border
                    width: 3.0, // Ketebalan border
                  )
                  ),
              child:  Text(
                nama_tombol_2,
                style: const TextStyle(
                    color: Color.fromARGB(255, 135, 203, 198),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ) : const SizedBox(height: 0.001)
        ],
      ),
    );
  }
}

