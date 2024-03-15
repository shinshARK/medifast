import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rumah_sakit/screens/home_screen.dart';
import 'package:rumah_sakit/models/notifikasi_model.dart';

// ignore: non_constant_identifier_names



// ignore: camel_case_types
class notifikasi_blur extends StatefulWidget {
  const notifikasi_blur({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _notifikasi_blurState createState() => _notifikasi_blurState();
}

// ignore: camel_case_types
class _notifikasi_blurState extends State<notifikasi_blur> {
  

  List<NotifikasiModel> hariIni = datanotifikasi.where((notif) {
    DateTime tanggalNotif = DateTime.parse(notif.tanggal);
    notif.status = true;
    return tanggalNotif.day == DateTime.now().day;
  }).toList();

  List<NotifikasiModel> kemarin = datanotifikasi.where((notif) {
    DateTime tanggalNotif = DateTime.parse(notif.tanggal);
    return tanggalNotif.day == DateTime.now().subtract(const Duration(days: 1)).day;
  }).toList();

  List<NotifikasiModel> mingguIni = datanotifikasi.where((notif) {
    DateTime tanggalNotif = DateTime.parse(notif.tanggal);
    return tanggalNotif.isAfter(DateTime.now().subtract(const Duration(days: 7)));
  }).toList();

  List<NotifikasiModel> lebihDariSeminggu = datanotifikasi.where((notif) {
    DateTime tanggalNotif = DateTime.parse(notif.tanggal);
    return tanggalNotif.isBefore(DateTime.now().subtract(const Duration(days: 7)));
  }).toList();

  
  // ignore: non_constant_identifier_names
void cek_estimasi_waktu(List<NotifikasiModel> data) {
  DateTime waktuSekarang = DateTime.now();
  for (var temp in data) {
    if (cek_hari(temp.tanggal) == 0) {
      DateTime tanggalWaktu = DateTime.parse(temp.tanggal);
      int jam2 = tanggalWaktu.hour;
      int menit2 = tanggalWaktu.minute;
      int detik2 = tanggalWaktu.second;
      int jam1 = waktuSekarang.hour;
      int menit1 = waktuSekarang.minute;
      int detik1 = waktuSekarang.second;

      if (jam1 - jam2 != 0) {
        temp.updatewaktu("${jam1 - jam2}h") ;
      } else if (menit1 - menit2 != 0) {
        temp.updatewaktu("${menit1 - menit2}m") ;
      } else {
        temp.updatewaktu( "${detik1 - detik2}d");
      }
    }
    
  }
  
}


// ignore: non_constant_identifier_names
int cek_data(int range){
  int cek = 0;
  for(int i = 0;i < datanotifikasi.length;i++){
    if(cek_hari(datanotifikasi[i].tanggal) == range){
      cek++;
    }
  }
  return cek;
}

// ignore: non_constant_identifier_names
List<int> posisi_data(int range){
  List<int> data = [];
  for(int i = 0;i < datanotifikasi.length;i++){
    if(cek_hari(datanotifikasi[i].tanggal) == range){
      data.add(i);
    }
  }
  return data;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
      ),
      body: Stack(
        children: <Widget>[
          const home_screen(), // Konten pertama
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.0),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                hariIni.isNotEmpty ? Column(
                  
                  children:  List.generate(hariIni.length,(index) {

                    return _katagori(hariIni, "Hari ini", 0,index);
                  }),
                ) : const SizedBox(
                  height: 0.01,
                ),
                hariIni.isNotEmpty ? const SizedBox(
                  height: 10,
                ) : const SizedBox(
                  height: 0.01,
                ),
                kemarin.isNotEmpty ? Column(
                  
                  children:  List.generate(kemarin.length,(index) {

                    return _katagori(kemarin, "Kemarin", 1,index);
                  }),
                ) : const SizedBox(
                  height: 0.01,
                ),
                kemarin.isNotEmpty ? const SizedBox(
                  height: 10,
                ) : const SizedBox(
                  height: 0.01,
                ),
                mingguIni.isNotEmpty ? Column(
                  
                  children:  List.generate(mingguIni.length,(index) {

                    return _katagori(mingguIni, "Minggu ini", 2,index);
                  }),
                ) : const SizedBox(
                  height: 0.01,
                ),
                mingguIni.isNotEmpty ? const SizedBox(
                  height: 10,
                ) : const SizedBox(
                  height: 0.01,
                ),
                lebihDariSeminggu.isNotEmpty ? Column(
                  
                  children:  List.generate(lebihDariSeminggu.length,(index) {

                    return _katagori(lebihDariSeminggu, "More", 3,index);
                  }),
                ) : const SizedBox(
                  height: 0.01,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ignore: prefer_final_fields
  List<bool> _tampilkanContainer = [true, true, false, false, false];
  Column _katagori(List<NotifikasiModel> data, String judulKatagori, int cek,int posisi) {
    return Column(
      children: [
        Container(
          alignment: posisi == 0 ? Alignment.topLeft : null,
          margin: posisi == 0
              ? const EdgeInsetsDirectional.only(start: 20, bottom: 10)
              : null,
          child: posisi == 0
              ?  GestureDetector(
                onTap: () {
                  setState(() {
                    _tampilkanContainer[cek] = !_tampilkanContainer[cek];
                    if(cek == 0){
                      
                      cek_estimasi_waktu(data);
                    }
                  });
                },
                child: Text(
                    judulKatagori,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 133, 133, 133), fontSize: 16),
                  ),
              )
              : cek_hari(data[posisi].tanggal) == cek && _tampilkanContainer[cek]
                  ? const SizedBox(
                      height: 20,
                    )
                  : null,
        ),
        cek_hari(data[posisi].tanggal) == cek
            ? _tampilkanContainer[cek] ? Stack(
                children: [
                  Container(
                    width: 364,
                    height: 122,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 135, 203, 198),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4.0,
                            offset: const Offset(
                                0, 4), // changes position of shadow
                          ),
                        ]),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.only(left: 30),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 219, 231, 116),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 4.0,
                                      offset: const Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                            data[posisi].icon
                                        ,
                                    size: 29,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 166,
                                margin:
                                    const EdgeInsets.only(left: 30, right: 40),
                                child: Text(
                                  "Selamat ${cek_waktu()}, Ilham",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                                )),
                            Container(
                                width: 166,
                                margin:
                                    const EdgeInsets.only(left: 30, right: 40),
                                child: Text(
                                  data[posisi].keterangan,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 303, top: 20),
                    child: Text(
                      data[posisi].selisih,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 133, 133, 133),
                          fontSize: 13),
                    ),
                  )
                ],
              ) 
            : const SizedBox(height: 0.1) : const SizedBox(height: 0.1),
      ],
    );
  }
  
}


// ignore: non_constant_identifier_names
String cek_waktu() {
  DateTime waktuSekarang = DateTime.now();
  int jam = waktuSekarang.hour;
  if (jam >= 4 && jam < 10) {
    return "Pagi";
  } else if (jam >= 10 && jam < 14) {
    return "Siang";
  } else if (jam >= 14 && jam < 18) {
    return "Sore";
  } else {
    return "Malam";
  }
}

DateTime epoch = DateTime.fromMillisecondsSinceEpoch(0);

// ignore: non_constant_identifier_names
int cek_hari(String tanggalWaktuString) {
  DateTime tanggalWaktu = DateTime.parse(tanggalWaktuString);
  DateTime waktuSekarang = DateTime.now();

  int selisihHari = waktuSekarang.difference(tanggalWaktu).inDays;

  if (selisihHari == 0) {
    return 0;
  } else if (selisihHari == 1) {
    return 1;
  } else if (selisihHari < 7) {
    return 2;
  } else {
    return 3;
  }
}
