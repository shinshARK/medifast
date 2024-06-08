import 'package:flutter/material.dart';


// ignore: camel_case_types
class highlight extends StatefulWidget {
  final int inputan;
  final String logo,kalimat;
  final Function redirect;
  const highlight({super.key, required this.inputan, required this.logo, required this.kalimat,required this.redirect});

  @override
  // ignore: library_private_types_in_public_api
  _highlightState createState() => _highlightState();
}

// ignore: camel_case_types
class _highlightState extends State<highlight> {
  int ?inputan;
  String ?logo,kalimat;
  late Function redirect;
  @override
  void initState() {
    super.initState();
    inputan = widget.inputan;
    kalimat = widget.kalimat;
    logo = widget.logo;
    redirect = widget.redirect;
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        redirect();
        // backgroundColor: const Color.fromARGB(255, 219, 231, 116)
        // Aksi ketika Container diklik
        print("test");
      },
      child: Stack(
        children: [
          Container(
            width: 300,
            height: 78,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 60),
            margin: const EdgeInsets.only(left: 20,top: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 219, 231, 116),
              borderRadius: BorderRadius.circular(10.0)
              ),
            child: Text(
              "$kalimat",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 102, // Lebar
            height: 102, // Tinggi
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 135, 203, 198), // Warna latar belakang
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 82, // Lebar
              height: 82, // Tinggi
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/$logo', // Path ke gambar di assets
                fit: BoxFit
                    .cover, // Cara gambar disesuaikan dengan ukuran yang ditentukan
              ),
            ),
          ),
        ],
      ),
    );
  }
  
 
  

  
  
}
