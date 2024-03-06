import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:rumah_sakit/screens/home_screen.dart';
import 'dart:async';



// ignore: must_be_immutable, camel_case_types
class riwayatTransaksi extends StatefulWidget {
  const riwayatTransaksi({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _riwayatTransaksiState createState() => _riwayatTransaksiState();
}







// ignore: camel_case_types
class _riwayatTransaksiState extends State<riwayatTransaksi> {
  var riwayatPemesanan = [{"nama Dokter":"Dr. Eka Rakhman Z.Sp.A","Spesialis":"Dokter Anak","Status Riwayat":"Segera","Tanggal" : "2024-03-04","jam":"02:00:00.857"}];
  var riwayatResep = [];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: _bottomNavigasiBar(),
      
      appBar: AppBar(
        title: const Text('Riwayat Transaksi',style: TextStyle(fontWeight: FontWeight.w700),),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      backgroundColor: Colors.black.withOpacity(0.1),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(1, (index) {
            return _riwayat(2,true,false,1);
          }),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  var menu_icon = [
    Icons.home,
    Icons.calendar_month,
    Icons.person,
    Icons.format_list_bulleted,
    Icons.account_circle_outlined
  ];

  // ignore: non_constant_identifier_names
  var menu_label = ["Beranda", "Riwayat", "Doktor", "Artikel", "Profil"];
  final int _selectedIndex = 1;

  BottomNavigationBar _bottomNavigasiBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      
      showUnselectedLabels: true,
      items: menu_icon
          .asMap()
          .entries
          .map((e) => BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: (){
                    if(e.key == 0){
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          // ignore: non_constant_identifier_names
                          builder: (Context) => home_screen(),
                        ),
                        (route) => false);
                    }
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: _selectedIndex == e.key
                          ? const Color.fromARGB(255, 135, 203, 198)
                          : null, // Warna latar belakang saat item dipilih
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: _selectedIndex ==
                              e.key // Menambahkan efek bayangan saat item dipilih
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4.9,
                                offset:
                                    const Offset(0, 0), // changes position of shadow
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(e.value,size: 40,color: _selectedIndex == e.key
                                  ? Colors.white
                                  : Colors.black,), // Mengubah ukuran ikon
                        Text(
                          menu_label[e.key],
                          style: TextStyle(
                              color: _selectedIndex == e.key
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 8),
                              textAlign: TextAlign.center,
                        ), // Menambahkan label ke dalam Container
                      ],
                    ),
                  ),
                ),
                label: '', // Menghapus label dari BottomNavigationBarItem
              ))
          .toList(),
    );
  }

  Center _riwayat(int jumlahTombol,bool keterangan,bool pembatasKeterangan,int jenisPilihan){
    return Center(
      child: Container(
        width: 320,
        height: 180,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              blurRadius: 2.0,
              offset: const Offset(
                  0, 4), // changes position of shadow
            ),
          ]
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.white.withOpacity(0.0),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/profile_picture_2.png'), // Ganti dengan path foto Anda
                  ),
                )
                ,
                Column(
                  children: [
                    Container(
                      width: 200,
                      child: Text(jenisPilihan == 1 ? riwayatPemesanan[0]["nama Dokter"]:riwayatResep[0],style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    keterangan == true ? Row(
                      children: [
                        Text("Dokter Anak "),
                        pembatasKeterangan == true ? Text("|") : Text(" "),
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(riwayatPemesanan[0]["Status Riwayat"]!,style: TextStyle(color: Color.fromARGB(255, 255, 255, 0)),textAlign: TextAlign.center,),
                        )
                      ],
                    ) : const SizedBox(
                      height: 0,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text("15 fubuari 2023 | 11:00")
                  ],
                )
              ],
            ),
            Container(
              width: 290,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.only(right: 20,top: 20),
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color.fromARGB(255, 135, 203, 198), // Warna border
                          width: 3.0, // Ketebalan border
                        )
                      ),
                      child: Text("Batalkan Booking",style: TextStyle(color: Color.fromARGB(255, 135, 203, 198)),textAlign: TextAlign.center,),
                    ),
                  ),
                   GestureDetector(
                    onTap: (){
                      
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      alignment: AlignmentDirectional.center,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 135, 203, 198),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text("Detail",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
