import 'package:flutter/material.dart';

// ignore: camel_case_types
class rating extends StatefulWidget {
  const rating({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ratingState createState() => _ratingState();
}


// ignore: camel_case_types
class _ratingState extends State<rating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Nilai',style: TextStyle(fontWeight: FontWeight.w700),),
        elevation: 10,
        shadowColor: Colors.white,
        
      ),
      // kalau mau nambahin const nya hapus aja 
      body: const Column(
          children: [
            Text("Rating"),
            
          ],
      ),
      bottomNavigationBar: _BottomNavigasiBar(context),
    );
  }

  BottomAppBar _BottomNavigasiBar(BuildContext context) {
  return BottomAppBar(
    color: Colors.white,
    child: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 350,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 135, 203, 198),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4.9,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: const Text(
          'Simpan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}


}