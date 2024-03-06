import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:rumah_sakit/screens/notifikasi_blur.dart';
import 'package:rumah_sakit/screens/riwayatTransaksi.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';

import 'dart:async';

//home_screen

// ignore: must_be_immutable, camel_case_types
class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  late ScrollController _controller;
  late Timer _timer;

  int _cek = 0;
  bool _tujuan = true;
  
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer t) {
      if(_controller.offset > 740 && _tujuan == true){
        _tujuan = false;
      }
      if(_controller.offset < 20 && _tujuan == false){
          _tujuan = true;
        }
      if (_controller.hasClients && _tujuan == true) {
        _controller.animateTo(
          _controller.offset + (_controller.offset % 377 == 0 ? 377 : (_controller.offset < 377 ? (377 - _controller.offset) : (754 - _controller.offset))), // 200 is the distance to scroll each time
          
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 800),
        );
        
        
      }else if (_controller.hasClients && _tujuan == false) {
        _controller.animateTo(
          _controller.offset - (_controller.offset % 377 == 0 ? 377 : (_controller.offset < 377 ? _controller.offset : (_controller.offset - 377))), // 200 is the distance to scroll each time
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 800),
        );
        
        
      }
      
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigasiBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            _profil(context),
            const SizedBox(
              height: 5,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Selamat Pagi\n",
                    style: GoogleFonts.openSans(fontSize: 14),
                    children: const [
                      TextSpan(
                          text: "Ilham Akbar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 18))
                    ])),
            const SizedBox(
              height: 5,
            ),
            _fitur_1(),
            const SizedBox(
              height: 5,
            ),
            _fitur_2(),
            const SizedBox(
              height: 5,
            ),
            _fitur_3(),
            _artikel_fitur(),
            Container(
              height: 172,
              margin: const EdgeInsets.only(left: 15,right: 10),
              child: ListView.separated(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index) => _artikel_populer(),
                separatorBuilder: (context, index) => const SizedBox(width: 20.0,),
                itemCount: 3,
              ),
            )
            ,
            
          ],
        ),
      ),
    );
  }
  
  // ignore: non_constant_identifier_names
  GestureDetector _artikel_populer() {
    return GestureDetector(
      onTap: (){
                    
      },
      child: Container(
        width: 360.0,
        height: 172.0,
        margin: const EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 231, 116),
              Color.fromARGB(255, 135, 203, 198)
            ], // Ganti dengan warna yang Anda inginkan
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 178.0,
              height: 162.0,
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: const Text(
                  'Alergi sering kambuh? Segera Konsultasi dengan Dokter Ini',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ),
            Container(
              width: 180.0,
              height: 180.0,
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/image_61.png'),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row _artikel_fitur() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: Text("Artikel terkini\n",
                style: GoogleFonts.openSans(
                    fontSize: 24, fontWeight: FontWeight.w700))),
        Padding(
          padding: const EdgeInsets.only(bottom: 20), // Padding di semua sisi
          child: TextButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(90.0, 16.0), // Ukuran minimum tombol
              ),
              child: const Text(
                'Lihat Semua', // Teks yang ditampilkan
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )),
        ),
      ],
    );
  }

  Stack _fitur_3() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 13.0, bottom: 13.0, left: 28), // Padding atas dan bawah
          child: TextButton(
            onPressed: () {
              // Aksi ketika tombol ditekan
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: const Color.fromARGB(
                  255, 219, 231, 116), // Warna latar belakang tombol
              minimumSize: const Size(296.0, 78.0), // Ukuran minimum tombol
            ),
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 65.0), // Padding untuk bagian kiri teks
              child: Text(
                'Pangilan Dokter\nke Rumah',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("halo");
            // Aksi ketika Container diklik
          },
          child: Container(
            width: 102, // Lebar
            height: 102, // Tinggi
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 135, 203, 198), // Warna latar belakang
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 20, right: 20),
              child: Image.asset(
                'assets/images/handshake.png', // Path ke gambar di assets
                fit: BoxFit
                    .cover, // Cara gambar disesuaikan dengan ukuran yang ditentukan
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _fitur_2() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 13.0, bottom: 13.0, left: 28), // Padding atas dan bawah
          child: TextButton(
            onPressed: () {
              // Aksi ketika tombol ditekan
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: const Color.fromARGB(
                  255, 219, 231, 116), // Warna latar belakang tombol
              minimumSize: const Size(296.0, 78.0), // Ukuran minimum tombol
            ),
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 65.0), // Padding untuk bagian kiri teks
              child: Text('Jadwal Janji',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("halo");
            // Aksi ketika Container diklik
          },
          child: Container(
            width: 102, // Lebar
            height: 102, // Tinggi
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 135, 203, 198), // Warna latar belakang
              shape: BoxShape.circle,
            ),
            child: const ClipOval(
              child: Icon(
                Icons.assignment_ind, // Ikon verifikasi user
                size: 48.0, // Ukuran ikon
                color: Colors.black, // Warna ikon
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _fitur_1() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 13.0, bottom: 13.0, left: 28), // Padding atas dan bawah
          child: TextButton(
            onPressed: () {
              // Aksi ketika tombol ditekan
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: const Color.fromARGB(
                  255, 219, 231, 116), // Warna latar belakang tombol
              minimumSize: const Size(296.0, 78.0), // Ukuran minimum tombol
            ),
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 65.0), // Padding untuk bagian kiri teks
              child: Text('Jadwalkan Langsung',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("halo");
            // Aksi ketika Container diklik
          },
          child: Container(
            width: 102, // Lebar
            height: 102, // Tinggi
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 135, 203, 198), // Warna latar belakang
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, bottom: 25.0, left: 30, right: 20),
              child: Image.asset(
                'assets/images/verified-account.png', // Path ke gambar di assets
                fit: BoxFit
                    .cover, // Cara gambar disesuaikan dengan ukuran yang ditentukan
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack _profil(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 144.0,
            height: 144.0,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 168, 168), // Warna bingkai
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                  8.0), // Jarak antara foto dan bingkai sekarang 20 pixel
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white.withOpacity(0.0),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/images/profile_picture_2.png'), // Ganti dengan path foto Anda
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => notifikasi_blur());
                  },
                  icon: const Icon(Icons.notifications),
                ),
                Positioned(
                  right: 8,
                  top: 5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
