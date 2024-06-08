import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rumah_sakit/screens/daftar_dokter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rumah_sakit/repositories/auth_repository.dart';
import 'package:rumah_sakit/screens/notifikasi_blur.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:rumah_sakit/components/highlight.dart';
import 'package:rumah_sakit/models/notifikasi_model.dart';
import 'package:rumah_sakit/models/layar_screens.dart';
import '../models/user_models.dart';

// ignore: must_be_immutable, camel_case_types
class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _home_screenState createState() => _home_screenState();
}

// ignore: camel_case_types
class _home_screenState extends State<home_screen> {
  late ScrollController _controller;
  late Timer _timer;

  UserModel? user;
  bool _tujuan = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _fetchUser();

    _timer = Timer.periodic(const Duration(seconds: 8), (Timer t) {
      if (_controller.offset >= ((screens.width - 5) * 2) && _tujuan == true) {
        _tujuan = false;
      }
      if (_controller.offset <= 10 && _tujuan == false) {
        _tujuan = true;
      }

      if (_controller.hasClients && _tujuan == true) {
        _controller.animateTo(
          _controller.offset +
              (_controller.offset % (screens.width - 5) == 0
                  ? (screens.width - 5)
                  : (_controller.offset < (screens.width - 5)
                      ? ((screens.width - 5) - _controller.offset)
                      : (((screens.width - 5) * 2) -
                          _controller
                              .offset))), // 200 is the distance to scroll each time

          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 800),
        );
      } else if (_controller.hasClients && _tujuan == false) {
        _controller.animateTo(
          _controller.offset -
              (_controller.offset % (screens.width - 5) == 0
                  ? (screens.width - 5)
                  : (_controller.offset < (screens.width - 5)
                      ? _controller.offset
                      : (_controller.offset -
                          (screens.width - 5)))), // 200 is the distance to scroll each time
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 800),
        );
      }
    });
  }

  Future<void> _fetchUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final AuthRepository authRepository = AuthRepository(sharedPreferences);
    setState(() {
      user = authRepository.getUser();
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
      bottomNavigationBar: const BottomNavigasiBar(inputan: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              _profil(context),
              const SizedBox(
                height: 5,
              ),
              Text.rich(
                TextSpan(
                  text: "Selamat Pagi\n",
                  style: GoogleFonts.openSans(fontSize: 14),
                  children: [
                    TextSpan(
                      text: "${user?.firstname ?? 'John'} ${user?.lastname ?? 'Doe'}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
               highlight(
                  inputan: 1, logo: 'handshake.png', kalimat: 'Jadwal Janji', redirect: () {Navigator.of(context).pushReplacementNamed('/Daftar-Dokter');},),
              const SizedBox(
                height: 20,
              ),
              highlight(
                  inputan: 1,
                  logo: 'IdentificationBadge.png',
                  kalimat: 'Pangilan Dokter\nke Rumah',
                  redirect: () {Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const daftar_dokter(mode: 0, filtel: ["Umum"],)),
              );}),
                  
              _artikel_fitur(),
              Container(
                height: 182,
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: ListView.separated(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _artikel_populer(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20.0,
                  ),
                  itemCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector _artikel_populer() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: (screens.width / pembagianlayar) - 25,
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
              width: ((screens.width / pembagianlayar) - 25) / 2,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: const Text(
                  'Alergi sering kambuh? Segera Konsultasi dengan Dokter Ini',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ),
            Container(
              width: ((screens.width / pembagianlayar) - 25) / 2,
              alignment: Alignment.bottomRight,
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
          padding:
              const EdgeInsets.only(bottom: 20), // Padding di semua sisi
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/Artikel');
              },
              style: TextButton.styleFrom(
                minimumSize:
                    const Size(90.0, 16.0), // Ukuran minimum tombol
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
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const notifikasi_blur());
                    });
                  },
                  icon: const Icon(Icons.notifications),
                ),
                cekstatus()
                    ? Positioned(
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
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        )
      ],
    );
  }

  bool cekstatus() {
    int jumlah = 0;
    for (var data in datanotifikasi) {
      if (!data.status) {
        jumlah++;
      }
    }
    return jumlah > 0;
  }
}
