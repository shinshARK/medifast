import 'dart:ui';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

//import 'package:google_fonts/google_fonts.dart';
//import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:rumah_sakit/screens/home_screen.dart';

// ignore: non_constant_identifier_names
var data_notifikasi = [
  [
    "1",
    "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi",
    "0",
    "2024-03-04 05:00:00.857"
  ],
  [
    "2",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-04 02:00:00.857"
  ],
  [
    "3",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-04 02:00:00.857"
  ],
  [
    "1",
    "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi",
    "0",
    "2024-03-04 05:00:00.857"
  ],
  [
    "2",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-04 02:00:00.857"
  ],
  [
    "3",
    "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!",
    "1",
    "2024-03-04 02:00:00.857"
  ]
];
// ignore: non_constant_identifier_names
var icon_notification = [
  Icons.medication_liquid_outlined,
  Icons.calendar_month
];

// ignore: camel_case_types
class notifikasi_blur extends StatelessWidget {
  const notifikasi_blur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
      ),
      body: Stack(
        children: <Widget>[
          home_screen(), // Konten pertama
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
                Column(
                  children: List.generate(data_notifikasi.length, (index) {
                    return _katagori(index, "hari ini", 0);
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(data_notifikasi.length, (index) {
                    return _katagori(index, "kemarin", 1);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _katagori(int index, String judulKatagori, int cek) {
    return Column(
      children: [
        Container(
          alignment: index == 0 ? Alignment.topLeft : null,
          margin: index == 0
              ? const EdgeInsetsDirectional.only(start: 20, bottom: 10)
              : null,
          child: index == 0
              ? Text(
                  judulKatagori,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 133, 133, 133), fontSize: 16),
                )
              : cek_hari(data_notifikasi[index][3]) == cek
                  ? const SizedBox(
                      height: 20,
                    )
                  : null,
        ),
        cek_hari(data_notifikasi[index][3]) == cek
            ? Stack(
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
            : const SizedBox.shrink(),
      ],
    );
  }
}

DateTime waktuSekarang = DateTime.now();

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

  int jumlahHari1 = waktuSekarang.difference(epoch).inDays;
  int jumlahHari2 = tanggalWaktu.difference(epoch).inDays;
  return jumlahHari1 - jumlahHari2;
}
