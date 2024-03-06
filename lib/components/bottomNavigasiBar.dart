import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:rumah_sakit/screens/notifikasi_blur.dart';
import 'package:rumah_sakit/screens/riwayatTransaksi.dart';
import 'dart:async';

class BottomNavigasiBar extends StatefulWidget {
  @override
  _BottomNavigasiBarState createState() => _BottomNavigasiBarState();
}

class _BottomNavigasiBarState extends State<BottomNavigasiBar> {
  var menu_icon = [
    Icons.home,
    Icons.calendar_month,
    Icons.person,
    Icons.format_list_bulleted,
    Icons.account_circle_outlined
  ];

  var menu_label = ["Beranda", "Riwayat", "Doktor", "Artikel", "Profil"];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      items: menu_icon
          .asMap()
          .entries
          .map((e) => BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: (){
                    if(e.key == 1){
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (Context) => riwayatTransaksi(),
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
                          : null,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: _selectedIndex == e.key
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 4.9,
                                offset: const Offset(0, 0),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(e.value,size: 40,),
                        Text(
                          menu_label[e.key],
                          style: TextStyle(
                              color: _selectedIndex == e.key
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 8),
                              textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                label: '',
              ))
          .toList(),
    );
  }
}


