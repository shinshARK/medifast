class ShiftModel{
  final String hari;
  final String tipe_shift;
  final int id_shift;


  ShiftModel({
    required this.hari,
    required this.tipe_shift,
    required this.id_shift,
  });

   factory ShiftModel.fromJson(Map<String, dynamic> json) {
    print(json['hari']);
    return ShiftModel(
      hari: json['hari'],
      tipe_shift: json['tipe_shift'],
      id_shift: json['id_shift'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hari': hari,
      'tipe_shift': tipe_shift,
      'id_shift': id_shift,
    };
  }

}

// var data_shift = [
//     ShiftModel(hari: "Senin", tipeshift: "Pagi"),
//     ShiftModel(hari: "Senin", tipeshift: "Sore"),
//     ShiftModel(hari: "Selasa", tipeshift: "Pagi"),
//     ShiftModel(hari: "Selasa", tipeshift: "Sore"),
//     ShiftModel(hari: "Rabu", tipeshift: "Pagi"),
//     ShiftModel(hari: "Rabu", tipeshift: "Sore"),
//     ShiftModel(hari: "Kamis", tipeshift: "Pagi"),
//     ShiftModel(hari: "Kamis", tipeshift: "Sore"),
//     ShiftModel(hari: "Jumat", tipeshift: "Pagi"),
//     ShiftModel(hari: "Jumat", tipeshift: "Sore"),
//     ShiftModel(hari: "Sabtu", tipeshift: "Pagi"),
//     ShiftModel(hari: "Sabtu", tipeshift: "Sore"),
//     ShiftModel(hari: "Minggu", tipeshift: "Pagi"),
//     ShiftModel(hari: "Minggu", tipeshift: "Sore"),
//   ];
