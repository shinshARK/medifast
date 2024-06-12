import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_event.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_state.dart';
import 'package:rumah_sakit/models/antrian_model.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';
import 'package:rumah_sakit/screens/catatan_dan_resep_dokter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPertemuan extends StatefulWidget {
  RiwayatTransaksiModel? data;
  int currentStep;

  DetailPertemuan({super.key, required this.data, required this.currentStep});

  @override
  // ignore: library_private_types_in_public_api
  _DetailPertemuanState createState() => _DetailPertemuanState();
}

class _DetailPertemuanState extends State<DetailPertemuan> {
  bool _showSuccessMessage = false;
  Timer? _timer;
  bool _showDetails = true;
  int _currentStep = 0;
  UserModel? user;
  AntrianModel? antrianModel;
  DokterModel? dokter;
  Future<void> _fetchUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final AuthRepository authRepository = AuthRepository(sharedPreferences);

    user = authRepository.getUser();
  }

  Future<void> _initialize() async {
    await _fetchUser();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    dokter = widget.data?.dokter;
    if (widget.data?.catatanDokter == null) {
      _currentStep = widget.currentStep;
    } else {
      _currentStep = 5;
    }
    antrianModel = widget.data?.antrian;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          if (_currentStep == 4) {
            final Map<String, String> transactionData = {
              'jam': '',
              'id_doctor': '',
              'id_antrian': '',
              'jumlah_pembayaran': '0',
              'id_user': '',
              'status': '',
              'id_pasien': '',
              'tipe_pembayaran': '',
              'id_resep_digital': '0',
              'id_catatan_dokter': '0',
            };

            context.read<TransactionBloc>().add(TransactionUpdateRequested(
                transactionId: widget.data!.id, updatedData: transactionData));
          }
          if(_currentStep < 5){
            _currentStep++;
          }
          if (_currentStep >= 5) {
            timer.cancel();
          }
        });
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showSuccessMessage = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is UpdateTransactionSuccess) {
        } else if (state is UpdateTransactionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('gagal update')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          elevation: 10,
          shadowColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _profil(context,dokter!.photo),
               Text(
                dokter!.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
               Text(dokter!.specialty),
              const SizedBox(height: 20), // Menambahkan ruang kosong
              Image.asset('assets/images/qrcode.png'), // Menambahkan gambar
              const SizedBox(height: 20), // Menambahkan ruang kosong
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0), // Menambahkan ruang di sebelah kiri
                child: Center(
                  // Widget Center
                  child: _showSuccessMessage
                      ? _successMessage(antrianModel!.id_antrian)
                      : _initialMessage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _initialMessage() {
    return const Text(
      "Silahkan scan QR-Code untuk melakukan Registrasi Ulang.",
      textAlign: TextAlign.center, // Teks rata tengah
      style: TextStyle(fontWeight: FontWeight.bold), // Teks tebal
    );
  }

  Widget _buildStepContent(int nomerAtrian) {
    switch (_currentStep) {
      case 0:
        return const Text(
            "Mohon tunggu sejenak untuk konfirmasi registrasi kembali...");
      case 1:
        return const Text(
            "Silakan menuju Nurse Station untuk pemeriksaan lanjutan.",
            textAlign: TextAlign.center);
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Mohon bersabar menunggu urutan Anda:"),
            const Text("Nomor Antrian Anda:"),
            Text(
              "$nomerAtrian",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text("Lokasi:"),
            const Text(
              "Gedung A, Lantai: Ruangan 305",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      case 3:
        return const Text("Anda saat ini dalam panggilan...",
            textAlign: TextAlign.center);
      case 4:
        return const Text("Sedang dalam proses pemeriksaan...",
            textAlign: TextAlign.center);
      case 5:
        return Column(
          children: [
            const Text(
              "Hasil pemeriksaan Anda sudah tersedia.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPertemuan(
                            data: widget.data,
                            currentStep: 5,
                          )),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => catatan_dan_resep_dokter(
                            data: widget.data, buttom: 1,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Text(
                'Lihat Hasil',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      default:
        return const Column(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 34.0,
            ),
            SizedBox(height: 8.0),
            Text(
              "Proses telah selesai.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
    }
  }

  Widget _successMessage(int nomerAtrian) {
    return Column(
      children: [
        const Text(
          "Registrasi Ulang Berhasil",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1BAC4B),
              fontSize: 24),
        ),
        const Text(
          "Untuk informasi lebih lanjut mengenai nomor antrian dan ruangan, silakan tekan tombol Detail di bawah ini.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF87CBC6),
                ),
                onPressed: () {
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      _showDetails
                          ? Icons.arrow_circle_down_outlined
                          : Icons.arrow_circle_right_outlined,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_showDetails)
              Container(
                width: MediaQuery.of(context).size.width -
                    60.0, // Width minus padding
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF87CBC6),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: _buildStepContent(nomerAtrian),
              ),
          ],
        )
      ],
    );
  }

  Stack _profil(BuildContext context,String foto) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: 144.0,
            height: 144.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white.withOpacity(0.0),
                child:  Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/$foto'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
