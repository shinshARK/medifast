import 'package:rumah_sakit/models/user_models.dart';
import 'package:rumah_sakit/models/dokter_model.dart';

class UserDokterModel{
  DokterModel dokter;
  UserModel user;


  UserDokterModel({
    required this.dokter,
    required this.user,
  });

}

// var data_dokter_shift = [
//     UserDokterModel(dokter: 1, user: 3),
//     UserDokterModel(dokter: 2, user: 1),
//     UserDokterModel(dokter: 3, user: 12),
//     UserDokterModel(dokter: 4, user: 7),
//     UserDokterModel(dokter: 5, user: 14),
//   ];
