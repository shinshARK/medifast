import 'package:rumah_sakit/models/resep_digital.dart';
class CatatanDokterModel{
  String gejala;
  String diagnosis;


  CatatanDokterModel({
    required this.gejala,
    required this.diagnosis,
  });

}

var data_catatan = [
  CatatanDokterModel(gejala: "Anak tubuh panas melebihi 37°C, batuk pilek dan flu, muntah berkepanjangan, jarang buang air kecil, tidak mengeluarkan air mata saat menangis, dan lemas.", diagnosis: "Mengalami Demam")
];
