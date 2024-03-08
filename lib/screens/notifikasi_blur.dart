import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rumah_sakit/screens/home_screen.dart';
DateTime waktuSekarang = DateTime.now();
String waktuSekarangString = waktuSekarang.toString();
// ignore: non_constant_identifier_names
var data_notifikasi = [
  [
    "1",
    "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi",
    "0",
    waktuSekarangString,
    ""
  ],
  [
    "2",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-08 20:00:00.857",
    ""
  ],
  [
    "3",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-09 02:00:00.857",
    ""
  ],
  [
    "1",
    "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi",
    "0",
    "2024-03-04 05:00:00.857",
    ""
  ],
  [
    "2",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-04 02:00:00.857",
    ""
  ],
  [
    "3",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-04 02:00:00.857",
    ""
  ]
];
// ignore: non_constant_identifier_names
var icon_notification = [
  Icons.medication_liquid_outlined,
  Icons.calendar_month
];


// ignore: camel_case_types
class notifikasi_blur extends StatefulWidget {
  const notifikasi_blur({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _notifikasi_blurState createState() => _notifikasi_blurState();
}

// ignore: camel_case_types
class _notifikasi_blurState extends State<notifikasi_blur> {


  
  // ignore: non_constant_identifier_names
String cek_estimasi_waktu(String tanggalWaktuString) {

  
  
  if (cek_hari(tanggalWaktuString) == 0) {
    DateTime tanggalWaktu = DateTime.parse(tanggalWaktuString);
    int jam2 = tanggalWaktu.hour;
    int menit2 = tanggalWaktu.minute;
    int detik2 = tanggalWaktu.second;
    int jam1 = waktuSekarang.hour;
    int menit1 = waktuSekarang.minute;
    int detik1 = waktuSekarang.second;

    if (jam1 - jam2 != 0) {
      return "${jam1 - jam2}h";
    } else if (menit1 - menit2 != 0) {
      return "${menit1 - menit2}m";
    } else {
      return "${detik1 - detik2}d";
    }
  }

  return "";
}

// ignore: non_constant_identifier_names
int cek_data(int range){
  int cek = 0;
  for(int i = 0;i < data_notifikasi.length;i++){
    if(cek_hari(data_notifikasi[i][3]) == range){
      cek++;
    }
  }
  return cek;
}

// ignore: non_constant_identifier_names
List<int> posisi_data(int range){
  List<int> data = [];
  for(int i = 0;i < data_notifikasi.length;i++){
    if(cek_hari(data_notifikasi[i][3]) == range){
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
                cek_data(0) > 0 ? Column(
                  
                  children:  List.generate(posisi_data(0).length,(index) {

                    return _katagori(posisi_data(0)[index], "hari ini", 0,index);
                  }),
                ) : const SizedBox(
                  height: 0.01,
                ),
                cek_data(0) > 0 ? const SizedBox(
                  height: 10,
                ) : const SizedBox(
                  height: 0.01,
                ),
                cek_data(1) > 0 ? Column(
                  
                  children:  List.generate(posisi_data(1).length,(index) {

                    return _katagori(posisi_data(1)[index], "Kemarin", 1,index);
                  }),
                ) : const SizedBox(
                  height: 0.01,
                ),
                cek_data(1) > 0 ? const SizedBox(
                  height: 10,
                ) : const SizedBox(
                  height: 0.01,
                ),
                cek_data(2) > 0 ? Column(
                  
                  children:  List.generate(posisi_data(2).length,(index) {

                    return _katagori(posisi_data(2)[index], "minggu ini", 2,index);
                  }),
                ) : const SizedBox(
                  height: 0.01,
                ),
                cek_data(2) > 0 ? const SizedBox(
                  height: 10,
                ) : const SizedBox(
                  height: 0.01,
                ),
                cek_data(3) > 0 ? Column(
                  
                  children:  List.generate(posisi_data(3).length,(index) {

                    return _katagori(posisi_data(3)[index], "more", 3,index);
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
  List<bool> _tampilkanContainer = [false, false, false, false, false];
  Column _katagori(int index, String judulKatagori, int cek,int posisi) {
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
                  });
                },
                child: Text(
                    judulKatagori,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 133, 133, 133), fontSize: 16),
                  ),
              )
              : cek_hari(data_notifikasi[index][3]) == cek && _tampilkanContainer[cek]
                  ? const SizedBox(
                      height: 20,
                    )
                  : null,
        ),
        cek_hari(data_notifikasi[index][3]) == cek
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
                                    icon_notification[int.tryParse(
                                            data_notifikasi[index][2]) ??
                                        0],
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
                                  data_notifikasi[index][1],
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
                      cek_estimasi_waktu(data_notifikasi[index][3]),
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
