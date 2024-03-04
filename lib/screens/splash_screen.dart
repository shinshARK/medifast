import 'package:flutter/material.dart';
import 'package:rumah_sakit/screens/halamanLogin.dart';
import 'package:rumah_sakit/screens/halamanRegistrasi.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 1)).then((value){
    //   // ignore: non_constant_identifier_names
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (Context) => home_screen(),), (route) => false);
    // });

    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Center(
              child: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/logo_1.png',
                    width: 270,
                    height: 270,
                  )
                ],
              )),
            )
          ]),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HalamanRegistrasi()),
              );
            },
            child: Container(
              width: 343,
              height: 52,
              margin: const EdgeInsets.only(top: 80),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 219, 231, 116),
                  borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Daftar",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HalamanLogin()),
              );
            },
            child: Container(
              width: 343,
              height: 52,
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 135, 203, 198),
                  borderRadius: BorderRadius.circular(30)),
              child: const Text(
                "Masuk",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
