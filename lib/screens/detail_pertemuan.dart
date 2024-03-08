import 'package:flutter/material.dart';





// ignore: camel_case_types
class detail_pertemuan extends StatefulWidget {
  const detail_pertemuan({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _detail_pertemuanState createState() => _detail_pertemuanState();
}

// ignore: camel_case_types
class _detail_pertemuanState extends State<detail_pertemuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail',style: TextStyle(fontWeight: FontWeight.w700),),
        elevation: 10,
        shadowColor: Colors.white,
        
      ),
      // kalau mau nambahin const nya hapus aja 
      body: const Column(
          children: [
            Text("detail")
          ],
      )
    );
  }

}