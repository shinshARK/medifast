// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:rumah_sakit/screens/detail_pertemuan.dart';
import 'package:rumah_sakit/screens/catatan_dan_resep_dokter.dart';

// ignore: must_be_immutable, camel_case_types
class riwayatTransaksi extends StatefulWidget {
  const riwayatTransaksi({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _riwayatTransaksiState createState() => _riwayatTransaksiState();
}

// ignore: camel_case_types
class _riwayatTransaksiState extends State<riwayatTransaksi> {
  var riwayatPemesanan = [
    {
      "nama Dokter": "Dr. Eka Rakhman Z.Sp.A",
      "Spesialis": "Dokter Anak",
      "Status Riwayat": "Segera",
      "Tanggal": "2024-03-04",
      "jam": "02:00:00.857",
      "gambar": "dokter_1.png",
      "pilihan": "jadwal"
    },
    {
      "nama Dokter": "Dr. Eka Rakhman Z.Sp.A",
      "Spesialis": "Dokter Anak",
      "Status Riwayat": "Selesai",
      "Tanggal": "2024-03-04",
      "jam": "02:00:00.857",
      "gambar": "dokter_1.png",
      "pilihan": "jadwal"
    },
    {
      "nama Dokter": "-",
      "Spesialis": "-",
      "Status Riwayat": "-",
      "Tanggal": "2024-03-04",
      "jam": "02:00:00.857",
      "gambar": "task_1.png",
      "pilihan": "catatan"
    },
    {
      "nama Dokter": "Dr. Endang Suharian,Sp.THT",
      "Spesialis": "Dokter THT",
      "Status Riwayat": "Batal",
      "Tanggal": "2024-03-04",
      "jam": "02:00:00.857",
      "gambar": "dokter_1.png",
      "pilihan": "jadwal"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigasiBar(context, inputan: 1),
      appBar: AppBar(
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      backgroundColor: Colors.black.withOpacity(0.1),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(4, (index) {
            return riwayatPemesanan[index]['pilihan'] == "jadwal"
                ? riwayatPemesanan[index]['Status Riwayat'] == "batal"
                    ? _riwayat(1, true, 1, index)
                    : _riwayat(2, true, 1, index)
                : _riwayat(1, false, 2, index);
          }),
        ),
      ),
    );
  }

  Center _riwayat(
      int jumlahTombol, bool keterangan, int jenisPilihan, int indek) {
    return Center(
      child: Container(
        width: 320,
        height: 180,
        margin: const EdgeInsets.only(top: 20),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 2.0,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ]),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.white.withOpacity(0.0),
                  child: keterangan == true
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                              "assets/images/${riwayatPemesanan[indek]['gambar']}"),
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/${riwayatPemesanan[indek]['gambar']}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        jenisPilihan == 1
                            ? riwayatPemesanan[indek]["nama Dokter"]!
                            : "Catatan Dokter & rersep",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 4,
                    ),
                    if (keterangan == true)
                      Row(
                        children: [
                          Text(riwayatPemesanan[0]['Spesialis']!),
                          const Text(" |"),
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                                color: riwayatPemesanan[indek]
                                            ["Status Riwayat"] ==
                                        "Segera"
                                    ? Colors.yellow.withOpacity(0.1)
                                    : riwayatPemesanan[indek]
                                                ["Status Riwayat"] ==
                                            "Selesai"
                                        ? Colors.green.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              riwayatPemesanan[indek]["Status Riwayat"]!,
                              style: TextStyle(
                                color: riwayatPemesanan[indek]
                                            ["Status Riwayat"] ==
                                        "Segera"
                                    ? Colors.yellow
                                    : riwayatPemesanan[indek]
                                                ["Status Riwayat"] ==
                                            "Selesai"
                                        ? Colors.green
                                        : Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    else
                      const SizedBox(
                        height: 0,
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    FutureBuilder<String>(
                      future: formatTanggalDanWaktu(
                          riwayatPemesanan[indek]["Tanggal"]!,
                          riwayatPemesanan[indek]
                              ["jam"]!), // panggil fungsi Anda di sini
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // tampilkan indikator loading saat menunggu
                        } else {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text(
                                '${snapshot.data}'); // tampilkan hasil fungsi
                          }
                        }
                      },
                    )
                  ],
                )
              ],
            ),
            Container(
              width: 290,
              alignment: AlignmentDirectional.center,
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))),
              child: jumlahTombol == 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // switch (riwayatPemesanan[indek]["Status Riwayat"]) {
                            //   case 'Segera':

                            //     break;
                            //   case 'Selesai':
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => rating()),
                            //     );

                            //     break;
                            //   tambahkan kasus lainnya sesuai kebutuhan
                            //   default:
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => HomePage()),
                            //     );
                            // }
                          },
                          child: Container(
                            width: 130,
                            height: 40,
                            alignment: AlignmentDirectional.center,
                            margin: const EdgeInsets.only(right: 20, top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 135, 203, 198), // Warna border
                                  width: 3.0, // Ketebalan border
                                )),
                            child: Text(
                              riwayatPemesanan[indek]["Status Riwayat"] ==
                                      "Segera"
                                  ? "Batalkan Booking"
                                  : "Nilai",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 135, 203, 198)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            switch (riwayatPemesanan[indek]["Status Riwayat"]) {
                              case 'Segera':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const detail_pertemuan()),
                                );

                                break;
                              //case 'Selesai':

                              //break;
                              // tambahkan kasus lainnya sesuai kebutuhan
                              //default:
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => HomePage()),
                              //   );
                            }
                          },
                          child: Container(
                            width: 130,
                            height: 40,
                            alignment: AlignmentDirectional.center,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 135, 203, 198),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              riwayatPemesanan[indek]["Status Riwayat"] ==
                                      "Segera"
                                  ? "Detail"
                                  : "jadwalkan kembali",
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    )
                  : GestureDetector(
                      onTap: () {
                        if (keterangan == false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const catatan_dan_resep_dokter()),
                          );
                        }
                      },
                      child: Container(
                        width: 260,
                        height: 40,
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 135, 203, 198),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          keterangan == false ? "Detail" : "jadwalkan ulang",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> formatTanggalDanWaktu(
      String tanggalInput, String jamInput) async {
    await initializeDateFormatting('id_ID', null);

    var tanggal = DateTime.parse(tanggalInput);
    var jam = TimeOfDay.fromDateTime(DateTime.parse("1970-01-01 $jamInput"));

    var formatterTanggal = DateFormat('dd MMMM yyyy', 'id_ID');
    var formatterJam = DateFormat('HH:mm', 'id_ID');

    var tanggalFormatted = formatterTanggal.format(tanggal);
    var jamFormatted =
        formatterJam.format(DateTime(1970, 1, 1, jam.hour, jam.minute));

    return "$tanggalFormatted | $jamFormatted";
  }
}
