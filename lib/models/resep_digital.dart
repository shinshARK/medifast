import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/models/obat_model.dart';
class ResepDigital {
  final int idResepDigital;
  final int idDoctor;
  final int idPasien;
  final int idObat;

  ResepDigital({
    required this.idResepDigital,
    required this.idDoctor,
    required this.idPasien,
    required this.idObat,
  });

  factory ResepDigital.fromJson(Map<String, dynamic> json) {
    return ResepDigital(
      idResepDigital: json['id_resep_digital'],
      idDoctor: json['id_doctor'],
      idPasien: json['id_pasien'],
      idObat: json['id_obat'],
    );
  }
}



  // var data_resep_digital = [
  //   RiwayatTransaksiModel(idDokter: 1, idUser: 1, idObat: 1),
  //   RiwayatTransaksiModel(idDokter: 4, idUser: 5, idObat: 2),
  //   RiwayatTransaksiModel(idDokter: 5, idUser: 4, idObat: 3),
  // ];

