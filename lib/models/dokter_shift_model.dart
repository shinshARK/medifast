import 'package:rumah_sakit/models/antrian_model.dart';
import 'package:rumah_sakit/models/shift_model.dart';

class DokterShiftModel{
  final int id_doctor_shift;
  final int id_doctor;
  final int id_shift;
  final ShiftModel shift_type;
  final List<AntrianModel> antrian;


  DokterShiftModel({
     required this.id_doctor_shift,
    required this.id_doctor,
    required this.id_shift,
    required this.shift_type,
    required this.antrian,
  });

  factory DokterShiftModel.fromJson(Map<String, dynamic> json) {
    var list = json['antrian'] as List;
    List<AntrianModel> antrianList = list.map((i) => AntrianModel.fromJson(i)).toList();
    print(json['id_doctor_shift']);
    return DokterShiftModel(
      id_doctor_shift: json['id_doctor_shift'],
      id_doctor: json['id_doctor'],
      id_shift: json['id_shift'],
      shift_type: ShiftModel.fromJson(json['shift_type']),
      antrian: antrianList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_doctor_shift': id_doctor_shift,
      'id_doctor': id_doctor,
      'id_shift': id_shift,
      'shift_type': shift_type.toJson(),
      'antrian': antrian.map((e) => e.toJson()).toList(),
    };
  }

}

// var data_dokter_shift = [
//     DokterShiftModel(dokter: 1, shift: 3),
//     DokterShiftModel(dokter: 2, shift: 1),
//     DokterShiftModel(dokter: 3, shift: 12),
//     DokterShiftModel(dokter: 4, shift: 7),
//     DokterShiftModel(dokter: 5, shift: 14),
//   ];
