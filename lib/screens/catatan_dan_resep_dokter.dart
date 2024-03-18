import 'package:flutter/material.dart';
import 'package:rumah_sakit/components/popupcustom.dart';
import 'package:rumah_sakit/screens/pembayaran_obat.dart';

// ignore: camel_case_types
class catatan_dan_resep_dokter extends StatefulWidget {
  const catatan_dan_resep_dokter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _catatan_dan_resep_dokterState createState() =>
      _catatan_dan_resep_dokterState();
}

var botton = ["Beli di Apotek", "Simpan Detail Obat"];

// ignore: camel_case_types
class _catatan_dan_resep_dokterState extends State<catatan_dan_resep_dokter> {
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
                child: Text(
                  'Gejala\nAnak tubuh panas melebihi 37°C, batuk pilek dan flu, muntah berkepanjangan, jarang buang air kecil, tidak mengeluarkan air mata saat menangis, dan lemas.\n\nKemungkinan Diagnosis\n> Mengalami Demam',
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
                      'Eki Rakhmah Z',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Sp. Anak'),
                    Text('SIP. 449.1/310/SIP/D/P1/PM/PT'),
                    SizedBox(height: 8),
                    Text(
                      'Nama Pasien',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Immanuel Carlos, Pria, 6 Tahun'),
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
                        Text('R/ Ibuprofen'),
                        Text('1 per tube'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Aktifkan pengingat minum obat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.check_box_outline_blank),
                        SizedBox(width: 8),
                        Text('Aktifkan'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavigasiBar(context),
    );
  }

  BottomNavigationBar _BottomNavigasiBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      onTap: (index) {
        // Lakukan sesuatu untuk semua item di sini

        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const pembayaran_obat(),
            ),
          );
        } else if (index == 1) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                child: PopupCustom(
                  page1: () {
                    Navigator.pop(context);
                  },
                  page2: () {},
                  jumlah_tombol: 1,
                  notif: 'berhasil',
                  judul_notif: 'Detail obat\nBerhasil Di simpan',
                  penjelasan_tambahan: '',
                  nama_tombol_1: 'Tutup',
                  nama_tombol_2: '',
                ),
              );
            },
          );
          // Lakukan sesuatu untuk item kedua di sini
        }
      },
      items: botton
          .asMap()
          .entries
          .map(
            (e) => BottomNavigationBarItem(
              icon: Container(
                width: 200,
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
                child: Text(
                  botton[e.key],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              label: '',
            ),
          )
          .toList(),
    );
  }
}
