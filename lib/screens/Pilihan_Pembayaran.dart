import 'package:flutter/material.dart';
import 'package:rumah_sakit/components/popupcustom.dart';

// ignore: camel_case_types
class Pilihan_Pembayaran extends StatefulWidget {
  const Pilihan_Pembayaran({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Pilihan_PembayaranState createState() => _Pilihan_PembayaranState();
}


// ignore: camel_case_types
class _Pilihan_PembayaranState extends State<Pilihan_Pembayaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('pembayaran',style: TextStyle(fontWeight: FontWeight.w700),),
        elevation: 10,
        shadowColor: Colors.white,
        
      ),
      // kalau mau nambahin const nya hapus aja 
      body: const Column(
          children: [
            Text("Silahkan pilih metode pembayaran yang akan anda gunakan"),
            
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
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(child: PopupCustom(page1: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              
            }, page2: (){}, jumlah_tombol: 1, notif: 'berhasil', judul_notif: 'pembayaran\nBerhasil', penjelasan_tambahan: 'Silahkan menuggu sesuai\ndengan Nomer Antrial yang tertera\nNomer Antrian : 12', nama_tombol_1: 'Kembali ke Riwayat Traansaksi', nama_tombol_2: '',
            
            ));
          },
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
          'Bayar',
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