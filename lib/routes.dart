import 'package:flutter/material.dart';
import 'package:rumah_sakit/screens/HalamanProfil.dart';
import 'package:rumah_sakit/screens/daftar_dokter.dart';
import 'package:rumah_sakit/screens/halamanArtikel.dart';
import 'package:rumah_sakit/screens/home_screen.dart';
import 'package:rumah_sakit/screens/halamanLogin.dart';
import 'package:rumah_sakit/screens/halamanRegistrasi.dart';
import 'package:rumah_sakit/screens/riwayatTransaksi.dart';
import 'package:rumah_sakit/screens/splash_screen.dart';
final Map<String, WidgetBuilder> routes = {
  '/login': (context) => const HalamanLogin(),
  '/register': (context) => const HalamanRegistrasi(),
  '/home': (context) => const home_screen(),
  '/riwayat-transaksi': (context) => const riwayatTransaksi(),
  '/Daftar-Dokter': (context) => const daftar_dokter(mode: 1, filtel: ["Semua", "Umum", "Anak", "Dalam"],),
  '/Artikel' : (context) => const halamanArtikel(),
  '/Profil' : (context) => const HalamanProfil(),
  '/Splash' : (context) => const SplashScreen(),
};
