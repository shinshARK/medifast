class DokterModel{
  String nama;
  String image;
  String spesialis;
  String rating;
  bool tanda;

  DokterModel({
    required this.nama,
    required this.image,
    required this.spesialis,
    required this.rating,
    required this.tanda
  });

  void setTanda(bool newValue) {
    tanda = newValue;
  }
}


// ignore: non_constant_identifier_names
var data_dokter = [
  DokterModel(nama: "Dr. Eki Rakhmah Z, Sp.A",spesialis: "Dokter Anak",rating: "4.8",tanda: true,image: "dokter_1.png"),
  DokterModel(nama: "Dr. Yudi Heriyanto",spesialis: "Dokter Umum",rating: "4.2",tanda: false,image: "dokter_4.png"),
  DokterModel(nama: "Dr. Rina wijaya, Sp.PD",spesialis: "Dokter Dalam",rating: "4.8",tanda: false,image: "dokter_2.png"),
  DokterModel(nama: "Dr. Budi Santoso, Sp.A",spesialis: "Dokter Anak",rating: "4.3",tanda: true,image: "dokter_5.png"),
  DokterModel(nama: "Dr. Lilis",spesialis: "Dokter Umum",rating: "4.5",tanda: false,image: "dokter_3.png")
];