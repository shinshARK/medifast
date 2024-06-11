// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rumah_sakit/components/popupcustom.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/models/obat_model.dart';
import 'package:rumah_sakit/models/pasien_model.dart';
import 'package:rumah_sakit/models/resep_digital.dart';
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';
import 'package:rumah_sakit/screens/Pilihan_Pembayaran.dart';
import 'package:rumah_sakit/screens/pembayaran_obat.dart';
import 'package:rumah_sakit/models/catatan_dokter_model.dart';
import 'package:rumah_sakit/components/toggleText.dart';
// ignore: camel_case_types
class catatan_dan_resep_dokter extends StatefulWidget {
  RiwayatTransaksiModel? data;
  int buttom;
  catatan_dan_resep_dokter({super.key, required this.data, required this.buttom});

  @override
  // ignore: library_private_types_in_public_api
  _catatan_dan_resep_dokterState createState() =>
      _catatan_dan_resep_dokterState();
}

var botton = ["Beli di Apotek", "Simpan Detail Obat"];

// ignore: camel_case_types
class _catatan_dan_resep_dokterState extends State<catatan_dan_resep_dokter> {
  CatatanDokterModel ?catatanDokter;
  ResepDigital ?resepDigital;
  PasienModel ?pasien;
  DokterModel ?dokter;

  void initState() {
    super.initState();
    catatanDokter = widget.data?.catatanDokter;
    resepDigital = widget.data?.resepDigital;
    pasien = widget.data?.pasien;
    dokter = widget.data?.dokter;
  }

  String carispecialty(String nama){
    List<String> kata = nama.split(' ');
    return kata[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catatan Dokter & Resep',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Catatan Dokter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gejala", // Display Gejala heading
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      catatanDokter!.gejala, // Display Gejala body
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Diagnosis", // Display Diagnosis heading
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            ((catatanDokter!.diagnosa).isEmpty ? "Belum ada Diagnosa" : catatanDokter!.diagnosa), // Display Diagnosis body
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

              ),
              SizedBox(height: 16),
              Text(
                'Resep Digital',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${dokter?.name}',
                      style: TextStyle(
                         fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Sp. ${carispecialty(dokter!.specialty)}'),
                    Text('SIP. 449.1/310/SIP/D/P1/PM/PT'),
                    SizedBox(height: 8),
                    Text(
                      'Nama Pasien',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${pasien?.namaPasien}, ${pasien?.jenisKelamin}, ${pasien?.umur} Tahun'),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nama Produk',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Jumlah',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${data_obat[resepDigital!.idObat]}'),
                        Text('1 per tube'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktifkan pengingatin minum obat',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ToggleTextWidget(firstValue: "Aktifkan", secondValue: "Nonaktifkan")
                        
                      ],
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.buttom == 1 ? _BottomNavigasiBar(context) : null,
    );
  }

  BottomAppBar _BottomNavigasiBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Pilihan_Pembayaran(data: widget.data,)),
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
            'Pembanyaran',
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
