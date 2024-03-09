import 'package:flutter/material.dart';
import 'package:rumah_sakit/screens/Pilihan_Pembayaran.dart';


// ignore: camel_case_types
class pembayaran_obat extends StatefulWidget {
  const pembayaran_obat({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _pembayaran_obatState createState() => _pembayaran_obatState();
}



// ignore: camel_case_types
class _pembayaran_obatState extends State<pembayaran_obat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Obat',style: TextStyle(fontWeight: FontWeight.w700),),
        elevation: 10,
        shadowColor: Colors.white,
        
      ),
      // kalau mau nambahin const nya hapus aja 
      body: const Column(
          children: [
            Text("Resep Digital"),
            Text("Detail Obat")
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                   const Pilihan_Pembayaran()),
        );
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
          'Lanjut ke Pembayaran',
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