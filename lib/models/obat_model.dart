class ObatModel{
  String namaobat;
  String tipe;
  String harga_satuan;


  ObatModel({
    required this.namaobat,
    required this.tipe,
    required this.harga_satuan,
  });

}

var data_obat = [
  ObatModel(namaobat: "Paracetamol.", tipe: "strip", harga_satuan: "1000"),
  ObatModel(namaobat: "amblodifin.", tipe: "kaplet", harga_satuan: "34000"),
  ObatModel(namaobat: "Paramex.", tipe: "sirup", harga_satuan: "8000")
];
