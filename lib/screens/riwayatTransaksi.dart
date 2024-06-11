// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_bloc.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_event.dart';
import 'package:rumah_sakit/blocs/riwayat/riwayat_state.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:rumah_sakit/components/popupcustom.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/repositories/auth_repository.dart';
import 'package:rumah_sakit/screens/catatan_dan_resep_dokter.dart';
import 'package:rumah_sakit/screens/informasi_dokter.dart';
import 'package:rumah_sakit/screens/rating.dart';
import 'package:rumah_sakit/models/riwayat_transaksi_model.dart';
import 'package:rumah_sakit/screens/detail_pertemuan.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable, camel_case_types
class riwayatTransaksi extends StatefulWidget {
  const riwayatTransaksi({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _riwayatTransaksiState createState() => _riwayatTransaksiState();
}

// ignore: camel_case_types
class _riwayatTransaksiState extends State<riwayatTransaksi> {
  List<RiwayatTransaksiModel> riwayattransaksi = [];
  UserModel? user;

  Future<void> _fetchUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final AuthRepository authRepository = AuthRepository(sharedPreferences);

    user = authRepository.getUser();
  }

  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _fetchUser();
    print(user?.id);
    print(user?.firstname);
    context.read<TransactionBloc>().add(TransactionRequested(
        userId:user?.id ?? 0)); // untuk sementara datanya akan saya masukan 1 dulu untuk yang dinamis bisa gunakan code ini user?.id ?? 0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Riwayat Transaksi',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 10,
          shadowColor: Colors.white,
        ),
        bottomNavigationBar: const BottomNavigasiBar(inputan: 1),
        body: BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is UpdateTransactionSuccess) {
              Navigator.of(context).pushReplacementNamed('/riwayat-transaksi');
            } else if (state is UpdateTransactionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('gagal menghapus data')),
              );
            }
          },
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) {
                Center(child: CircularProgressIndicator());

                print("data");
              } else if (state is TransactionLoaded) {
                riwayattransaksi = state.transactions;
                print(riwayattransaksi.length);
              } else if (state is TransactionFailure) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: List.generate(riwayattransaksi.length, (index) {
                      int reverseIndex = riwayattransaksi.length - 1 - index;
                      return _riwayat(riwayattransaksi[reverseIndex]);
                    }),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Padding _riwayat(RiwayatTransaksiModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        elevation: 5.0, // Nilai elevasi
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 2.0,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.white.withOpacity(0.0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage("assets/images/${data.dokter?.photo}"),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.dokter?.name ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Text(data.dokter?.specialty ?? ''),
                              const Text(" |"),
                              Container(
                                width: 60,
                                decoration: BoxDecoration(
                                    color: data.status == "Segera"
                                        ? Colors.yellow.withOpacity(0.1)
                                        : data.status == "Selesai"
                                            ? Colors.green.withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  data.status,
                                  style: TextStyle(
                                    color: data.status == "Segera"
                                        ? Colors.yellow
                                        : data.status == "Selesai"
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          FutureBuilder<String>(
                            future: formatTanggalDanWaktu(data.antrian!.tanggal,
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
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey))),
                child: data.status != "Batal"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                switch (data.status) {
                                  case 'Segera':
                                    final Map<String, String> transactionData =
                                        {
                                      'jam': '',
                                      'id_doctor': '',
                                      'id_antrian': '',
                                      'jumlah_pembayaran': '',
                                      'id_user': '',
                                      'status': 'Batal',
                                      'id_pasien': '',
                                      'tipe_pembayaran': '',
                                      'id_resep_digital': '',
                                      'id_catatan_dokter': '',
                                    };

                                    context.read<TransactionBloc>().add(
                                        TransactionUpdateRequested(
                                            transactionId: data.id,
                                            updatedData: transactionData));
                                    break;
                                  case 'Selesai':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => rating(dokter: data.dokter,)),
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
                                height: 40,
                                alignment: AlignmentDirectional.center,
                                margin:
                                    const EdgeInsets.only(right: 20, top: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 135, 203, 198), // Warna border
                                      width: 3.0, // Ketebalan border
                                    )),
                                child: Text(
                                  data.status == "Segera"
                                      ? "Batalkan Booking"
                                      : "Nilai",
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 135, 203, 198)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                switch (data.status) {
                                  case 'Segera':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                             DetailPertemuan(data: data,currentStep: 0,)),
                                    );

                                    break;
                                  case 'Selesai':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => informasi_dokter(
                                          key: ValueKey(data.dokter?.name),
                                          id: data.dokter!.id,
                                        ),
                                      ),
                                    );
                                  break;
                                  // tambahkan kasus lainnya sesuai kebutuhan
                                  // default:
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => HomePage()),
                                  //   );
                                }
                              },
                              child: Container(
                                height: 40,
                                alignment: AlignmentDirectional.center,
                                margin: const EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 135, 203, 198),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  data.status == "Segera"
                                      ? "Detail"
                                      : "Jadwalkan Kembali",
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => informasi_dokter(
                                key: ValueKey(data.dokter?.name),
                                id: data.dokter!.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
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
              data.status == "Selesai"
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  catatan_dan_resep_dokter(data: data, buttom: 0,)),
                        );
                      },
                      child: Container(
                        height: 40,
                        alignment: AlignmentDirectional.center,
                        margin:
                            const EdgeInsets.only(top: 20, left: 25, right: 25),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 135, 203, 198),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "Catatan Dokter & Resep",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
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
