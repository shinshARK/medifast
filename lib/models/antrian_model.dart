import 'package:rumah_sakit/models/dokter_shift_model.dart';

class DokterShiftModel{
  String tanggal;
  int current_antrian;
  int max_antrian;
  DokterShiftModel doktershift;

  DokterShiftModel({
    required this.tanggal, 
    required this.current_antrian,
    required this.max_antrian,
    required this.doktershift, 

  });

}

// var data_dokter_shift = [
//     DokterShiftModel(doktershift: 1, doktershift: 3),
//     DokterShiftModel(doktershift: 2, doktershift: 1),
//     DokterShiftModel(doktershift: 3, doktershift: 12),
//     DokterShiftModel(doktershift: 4, doktershift: 7),
//     DokterShiftModel(doktershift: 5, doktershift: 14),
//   ];
