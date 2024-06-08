import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/models/obat_model.dart';
class RiwayatTransaksiModel{
    DokterModel idDokter;
    UserModel idUser;
    ObatModel idObat;


    RiwayatTransaksiModel({
      required this.idDokter,
      required this.idUser,
      required this.idObat

    });
}

  // var data_resep_digital = [
  //   RiwayatTransaksiModel(idDokter: 1, idUser: 1, idObat: 1),
  //   RiwayatTransaksiModel(idDokter: 4, idUser: 5, idObat: 2),
  //   RiwayatTransaksiModel(idDokter: 5, idUser: 4, idObat: 3),
  // ];

