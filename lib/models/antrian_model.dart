class AntrianModel{
   final int current_antrian;
  final String tanggal;
  final int id_doctor_shift;
  final int id_antrian;
  final int max_antrian;

  AntrianModel({
   required this.current_antrian,
    required this.tanggal,
    required this.id_doctor_shift,
    required this.id_antrian,
    required this.max_antrian, 

  });

  factory AntrianModel.fromJson(Map<String, dynamic> json) {
    // print(json['tanggal']);
    return AntrianModel(
      current_antrian: json['current_antrian'],
      tanggal: json['tanggal'],
      id_doctor_shift: json['id_doctor_shift'],
      id_antrian: json['id_antrian'],
      max_antrian: json['max_antrian'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_antrian': current_antrian,
      'tanggal': tanggal,
      'id_doctor_shift': id_doctor_shift,
      'id_antrian': id_antrian,
      'max_antrian': max_antrian,
    };
  }

}

// var data_dokter_shift = [
//     DokterShiftModel(doktershift: 1, doktershift: 3),
//     DokterShiftModel(doktershift: 2, doktershift: 1),
//     DokterShiftModel(doktershift: 3, doktershift: 12),
//     DokterShiftModel(doktershift: 4, doktershift: 7),
//     DokterShiftModel(doktershift: 5, doktershift: 14),
//   ];
