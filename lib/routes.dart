import 'package:flutter/material.dart';
import 'package:rumah_sakit/screens/home_screen.dart';
import 'package:rumah_sakit/screens/halamanLogin.dart';
import 'package:rumah_sakit/screens/halamanRegistrasi.dart';
final Map<String, WidgetBuilder> routes = {
  '/login': (context) => HalamanLogin(),
  '/register': (context) => HalamanRegistrasi(),
  '/home': (context) => home_screen(),
};
