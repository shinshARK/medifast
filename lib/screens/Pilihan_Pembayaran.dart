import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_event.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_state.dart';
import 'package:rumah_sakit/components/popupcustom.dart';
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';
import 'package:rumah_sakit/screens/riwayatTransaksi.dart';

// ignore: camel_case_types
class Pilihan_Pembayaran extends StatefulWidget {
  RiwayatTransaksiModel? data;
   Pilihan_Pembayaran({super.key , required this.data});
  @override
  _Pilihan_PembayaranState createState() => _Pilihan_PembayaranState();
}

class _Pilihan_PembayaranState extends State<Pilihan_Pembayaran> {
  int pilihOpsi = 1;
  List<String> Opsi = ["BCA Virtual Account","BNI Virtual Account","Bayar Di Tempat"];
  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(listener: (context, state) {
      if (state is UpdateTransactionSuccess) {
        showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                      child: PopupCustom(
                    page1: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const riwayatTransaksi()),
                      );
                    },
                    page2: () {},
                    jumlah_tombol: 1,
                    notif: 'berhasil',
                    judul_notif: 'Berhasil\nMembanyar',
                    penjelasan_tambahan: '',
                    nama_tombol_1: 'Kembali',
                    nama_tombol_2: '',
                  ));
                },
              );
      } else if (state is UpdateTransactionFailure) {
        showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                      child: PopupCustom(
                    page1: () {
                      Navigator.pop(context);
                    },
                    page2: () {},
                    jumlah_tombol: 1,
                    notif: 'Gagal',
                    judul_notif: 'Gagal\nMembanyar',
                    penjelasan_tambahan: '',
                    nama_tombol_1: 'Coba ulangi',
                    nama_tombol_2: '',
                  ));
                },
              );
      }
    },
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran', style: TextStyle(fontWeight: FontWeight.w700)),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
        child: Column(
          children: [
            const Text("Silahkan pilih metode pembayaran yang akan anda gunakan"),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 244, 247, 100),
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                leading: Image.asset('assets/images/bca_logo.png'),
                title: const Text("BCA Virtual Account", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),),
                trailing: Radio<int>(
                  activeColor: const Color.fromRGBO(128, 211, 211, 100),
                  hoverColor: const Color.fromRGBO(128, 211, 211, 100),
                  value: 1,
                  groupValue: pilihOpsi,
                  onChanged: (value) {
                    setState(() {
                      pilihOpsi = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 244, 247, 100),
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                leading: Image.asset('assets/images/bni_logo.png'),
                title: const Text("BNI Virtual Account",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),),
                trailing: Radio<int>(
                  activeColor: const Color.fromRGBO(128, 211, 211, 100),
                  hoverColor: const Color.fromRGBO(128, 211, 211, 100),
                  value: 2,
                  groupValue: pilihOpsi,
                  onChanged: (value) {
                    setState(() {
                      pilihOpsi = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 244, 247, 100),
                borderRadius: BorderRadius.circular(15)
              ),
              child: ListTile(
                leading: Image.asset('assets/images/cod_logo.png'),
                title: const Text("Bayar Di Tempat", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14
                ),),
                trailing: Radio<int>(
                  activeColor: const Color.fromRGBO(128, 211, 211, 100),
                  hoverColor: const Color.fromRGBO(128, 211, 211, 100),
                  value: 3,
                  groupValue: pilihOpsi,
                  onChanged: (value) {
                    setState(() {
                      pilihOpsi = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavigasiBar(context),
    ),
    );
  }

  BottomAppBar _BottomNavigasiBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          final Map<String, String> transactionData = {
              'jam': '',
              'id_doctor': '',
              'id_antrian': '',
              'jumlah_pembayaran': '',
              'id_user': '',
              'status': 'Selesai',
              'id_pasien': '',
              'tipe_pembayaran': Opsi[pilihOpsi],
              'id_resep_digital': '',
              'id_catatan_dokter': '',
            };

            context.read<TransactionBloc>().add(TransactionUpdateRequested(
                transactionId: widget.data!.id, updatedData: transactionData));
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