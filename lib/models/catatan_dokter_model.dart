import 'package:rumah_sakit/models/resep_digital.dart';
class CatatanDokterModel{
  final int idCatatanDoctor;
  final String gejala;
  final String diagnosa;


  CatatanDokterModel({
    required this.idCatatanDoctor,
    required this.gejala,
    required this.diagnosa,
  });

  factory CatatanDokterModel.fromJson(Map<String, dynamic> json) {
    return CatatanDokterModel(
      idCatatanDoctor: json['id_catatan_doctor'],
      gejala: json['gejala'],
      diagnosa: json['diagnosa'],
    );
  }
}

// var data_catatan = [
//   CatatanDokterModel(idCatatanDoctor: 1,gejala: "Anak tubuh panas melebihi 37°C, batuk pilek dan flu, muntah berkepanjangan, jarang buang air kecil, tidak mengeluarkan air mata saat menangis, dan lemas.", diagnosa: "Mengalami Demam")
// ];
