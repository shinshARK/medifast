import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/models/shift_model.dart';

class DokterShiftModel{
  DokterModel dokter;
  ShiftModel shift;


  DokterShiftModel({
    required this.dokter,
    required this.shift,
  });

}

// var data_dokter_shift = [
//     DokterShiftModel(dokter: 1, shift: 3),
//     DokterShiftModel(dokter: 2, shift: 1),
//     DokterShiftModel(dokter: 3, shift: 12),
//     DokterShiftModel(dokter: 4, shift: 7),
//     DokterShiftModel(dokter: 5, shift: 14),
//   ];
