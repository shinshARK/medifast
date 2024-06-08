class ShiftModel{
  String hari;
  String tipeshift;


  ShiftModel({
    required this.hari,
    required this.tipeshift,
  });

}

var data_shift = [
    ShiftModel(hari: "Senin", tipeshift: "Pagi"),
    ShiftModel(hari: "Senin", tipeshift: "Sore"),
    ShiftModel(hari: "Selasa", tipeshift: "Pagi"),
    ShiftModel(hari: "Selasa", tipeshift: "Sore"),
    ShiftModel(hari: "Rabu", tipeshift: "Pagi"),
    ShiftModel(hari: "Rabu", tipeshift: "Sore"),
    ShiftModel(hari: "Kamis", tipeshift: "Pagi"),
    ShiftModel(hari: "Kamis", tipeshift: "Sore"),
    ShiftModel(hari: "Jumat", tipeshift: "Pagi"),
    ShiftModel(hari: "Jumat", tipeshift: "Sore"),
    ShiftModel(hari: "Sabtu", tipeshift: "Pagi"),
    ShiftModel(hari: "Sabtu", tipeshift: "Sore"),
    ShiftModel(hari: "Minggu", tipeshift: "Pagi"),
    ShiftModel(hari: "Minggu", tipeshift: "Sore"),
  ];
