import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_sakit/blocs/doctor/doctor_bloc.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/models/dokter_shift_model.dart';
import 'package:rumah_sakit/models/shift_model.dart';
import 'package:rumah_sakit/screens/daftar_dokter.dart';
import 'package:rumah_sakit/screens/reservasi.dart';

class informasi_dokter extends StatefulWidget {
  final int id;

  const informasi_dokter({required this.id, Key? key}) : super(key: key);

  @override
  _InformasiDokterState createState() => _InformasiDokterState();
}

class _InformasiDokterState extends State<informasi_dokter> {
  DokterModel? dokter;
  late Future<DokterModel> futureDoctor;
  int selecteddokter = 0;

  void initState() {
    super.initState();
    context.read<DoctorBloc>().add(DoctorByIdRequested(id: widget.id));
  }

  // List<int> posisi_data() {
  //   List<int> hasil = [];

  //   for (int i = 0; i < data_dokter.length; i++) {
  //     if (selecteddokter == 0) {
  //       hasil.add(i);
  //     } else if (data_dokter[i]
  //             .specialty
  //             ?.toLowerCase()
  //             .contains(dokter[selecteddokter].toLowerCase()) ==
  //         true) {
  //       hasil.add(i);
  //     }
  //   }

  //   return hasil;
  // }


  String CekShift(DokterModel data){
    String temp = "";
    for (var i = 0; i < data.doctor_shifts.length; i++) {
       DokterShiftModel doctorShift = data.doctor_shifts[i];
       ShiftModel shift = doctorShift.shift_type;
       if (!temp.contains(shift.hari)) {
         if(temp != ""){
           temp += " ";
         }
         temp += shift.hari;
       }
    }
    return temp;
}


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBloc, DoctorState>(
  builder: (context, state) {
    if (state is DoctorLoading) {
       CircularProgressIndicator();
    } else if (state is DoctorLoadedById) {
      dokter = state.dokter;
      print(dokter!.favorite);
    } else if (state is DoctorFailure) {
      Text('Error: ${state.error}');
    } 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${dokter?.name}",
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        shadowColor: Colors.white,
        actions: <Widget>[
        IconButton(
          icon: Icon(
            dokter != null && dokter!.favorite
                ? Icons.favorite
                : Icons.favorite_border,
            color: dokter != null && dokter!.favorite
                ? Colors.black
                : Colors.black,
            size: 30,
          ),
          onPressed: () {
            if (dokter != null) {
              setState(() {
                dokter!.favorite
                    ? dokter?.setTanda(false)
                    : dokter?.setTanda(true);
              });
            }
          },
        ),
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Card(
                color: Color(0xFFCCEEEE),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/${dokter?.photo}'),
                    radius: 30.0,
                  ),
                  title: Text('${dokter?.name}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text('${dokter?.specialty}',
                      style: const TextStyle(fontSize: 14)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(children: [
                          Text('${dokter?.experience} Tahun',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF8DB9FE))),
                          const Text('Pengalaman',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey))
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.yellow[600]),
                              Text('${dokter?.rating}',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF8DB9FE)))
                            ],
                          ),
                          const Text('Rating',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey))
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tentang',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${dokter?.about}',
                          style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Informasi Jam',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_month_outlined),
                        SizedBox(width: 10),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                              dokter != null ? CekShift(dokter!) : 'Loading...',
                              style: const TextStyle(fontSize: 14),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Testimoni',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {},
                          child: Text('lihat semua',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/profile_picture.png'),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text('Asep Sutarnan'),
                            ),
                            Icon(Icons.star, color: Colors.yellow[600]),
                            Text('4.8',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'sangat beruntung bisa berobat dengan Dr. Eki Rakhmah Zakiyyah, Sp.A. Sejak pertemuan pertama, beliau selalu memberikan penjelasan yang jelas dan mudah dimengerti tentang kondisi kesehatan saya. Beliau selalu sabar menjawab semua pertanyaan saya dan orang tua saya, dan membuat kami merasa diperhatikan dan dipahami. Pengobatan yang diberikan selalu efektif dan saya merasa lebih baik setelah setiap kunjungan.',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Saya sangat menghargai dedikasi dan profesionalisme Dr. Eki Rakhmah Zakiyyah. Beliau benar-benar peduli dengan pasiennya dan selalu berusaha memberikan perawatan terbaik. Saya sangat merekomendasikan Dr. Eki Rakhmah Zakiyyah kepada semua anak-anak yang membutuhkan perawatan medis berkualitas tinggi. Terima kasih, Dokter!',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            if (dokter != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Reservasi(
                    dokter: dokter!,
                  ),
                ),
              );
            }
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
              'Pesan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
