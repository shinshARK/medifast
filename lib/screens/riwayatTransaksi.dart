// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:rumah_sakit/screens/detail_pertemuan.dart';
import 'package:rumah_sakit/screens/catatan_dan_resep_dokter.dart';
import 'package:rumah_sakit/screens/rating.dart';
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';


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
      bottomNavigationBar: const BottomNavigasiBar( inputan: 1),
      appBar: AppBar(
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(riwayattransaksi.length, (index) {
            return _riwayat(riwayattransaksi[index]);
          }),
        ),
      ),
    );
  }

  Center _riwayat(RiwayatTransaksiModel data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Material(
          elevation: 5.0, // Nilai elevasi
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 320,
            height: data.status == "Selesai" ? 250 : 180,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.white.withOpacity(0.0),
                      child:
                          CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                  "assets/images/${data.dokter.image}"),
                            )
                          
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.dokter.nama,     
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 4,
                        ),
                          Row(
                            children: [
                              Text(data.dokter.spesialis),
                              const Text(" |"),
                              Container(
                                width: 60,
                                decoration: BoxDecoration(
                                    color: data.status ==
                                            "Segera"
                                        ? Colors.yellow.withOpacity(0.1)
                                        : data.status ==
                                                "Selesai"
                                            ? Colors.green.withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  data.status,
                                  style: TextStyle(
                                    color: data.status ==
                                            "Segera"
                                        ? Colors.yellow
                                        : data.status ==
                                                "Selesai"
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )
                        ,
                        const SizedBox(
                          height: 4,
                        ),
                        FutureBuilder<String>(
                          future: formatTanggalDanWaktu(
                              data.tanggal,
                              data.jam), // panggil fungsi Anda di sini
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
                  child: data.status != "Batal"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                switch (data.status) {
                                  case 'Segera':
          
                                    break;
                                  case 'Selesai':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const rating()),
                                    );
          
                                //     break;
                                //   tambahkan kasus lainnya sesuai kebutuhan
                                //   default:
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(builder: (context) => HomePage()),
                                //     );
                                }
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
                                  data.status ==
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
                                switch (data.status) {
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
                                  data.status ==
                                          "Segera"
                                      ? "Detail"
                                      : "Jadwalkan Kembali",
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            
                          },
                          child: Container(
                            width: 290,
                            height: 40,
                            alignment: AlignmentDirectional.center,
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 135, 203, 198),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "Jadwalkan Ulang",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
                data.status == "Selesai" ?
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const catatan_dan_resep_dokter()),
                    );
                  },
                  child: Container(
                    width: 290,
                    height: 40,
                    alignment: AlignmentDirectional.center,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 135, 203, 198),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "Catatan Dokter & Resep",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : const SizedBox()
              ],
            ),
          ),
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
