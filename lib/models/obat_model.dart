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
  ObatModel(namaobat: "Paramex.", tipe: "sirup", harga_satuan: "8000"),
  ObatModel(namaobat: "Ibuprofen.", tipe: "tablet", harga_satuan: "1500"),
  ObatModel(namaobat: "Cetirizine.", tipe: "kaplet", harga_satuan: "2000"),
  ObatModel(namaobat: "Amoxicillin.", tipe: "kapsul", harga_satuan: "5000"),
  ObatModel(namaobat: "Cough Syrup.", tipe: "sirup", harga_satuan: "7000"),
  ObatModel(namaobat: "Antacid.", tipe: "tablet", harga_satuan: "1200"),
  ObatModel(namaobat: "Loratadine.", tipe: "kaplet", harga_satuan: "1800"),
  ObatModel(namaobat: "Metformin.", tipe: "tablet", harga_satuan: "2500")
];

