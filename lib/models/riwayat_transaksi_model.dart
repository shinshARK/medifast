import 'package:rumah_sakit/models/antrian_model.dart';
import 'package:rumah_sakit/models/catatan_dokter_model.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/models/pasien_model.dart';
import 'package:rumah_sakit/models/resep_digital.dart';
import 'package:rumah_sakit/models/user_models.dart';
class RiwayatTransaksiModel {
  final int id;
  final String status;
  final String jam;
  final int idDoctor;
  final int idPasien;
  final int idAntrian;
  final String tipePembayaran;
  final String jumlahPembayaran;
  final int idUser;
  final int? idResepDigital; // Perbarui tipe data menjadi nullable
  final int? idCatatanDokter; // Perbarui tipe data menjadi nullable
  final DokterModel? dokter;
  final UserModel? user;
  final ResepDigital? resepDigital; // Perbarui tipe data menjadi nullable
  final CatatanDokterModel? catatanDokter; // Perbarui tipe data menjadi nullable
  final PasienModel? pasien;
  final AntrianModel? antrian;

  RiwayatTransaksiModel({
    required this.id,
    required this.status,
    required this.jam,
    required this.idDoctor,
    required this.idPasien,
    required this.idAntrian,
    required this.tipePembayaran,
    required this.jumlahPembayaran,
    required this.idUser,
    this.idResepDigital, // Tambahkan tanda tanya (?) di sini
    this.idCatatanDokter, // Tambahkan tanda tanya (?) di sini
    required this.dokter,
    required this.user,
    this.resepDigital, // Tambahkan tanda tanya (?) di sini
    this.catatanDokter, // Tambahkan tanda tanya (?) di sini
    required this.pasien,
    required this.antrian,
  });

  factory RiwayatTransaksiModel.fromJson(Map<String, dynamic> json) {
    
    return RiwayatTransaksiModel(
      id: json['transaction']['id_riwayat_transaksi'],
      status: json['transaction']['status'],
      jam: json['transaction']['jam'],
      idDoctor: json['transaction']['id_doctor'],
      idPasien: json['transaction']['id_pasien'],
      idAntrian: json['transaction']['id_antrian'],
      tipePembayaran: json['transaction']['tipe_pembayaran'],
      jumlahPembayaran: json['transaction']['jumlah_pembayaran'],
      idUser: json['transaction']['id_user'],
      idResepDigital: json['transaction']['id_resep_digital'],
      idCatatanDokter: json['transaction']['id_catatan_dokter'],
      dokter: DokterModel.fromJson(json['transaction_details']['doctor']),
      user: UserModel.fromJson(json['transaction_details']['user']),
      resepDigital: json['transaction_details']['resep_digital'] != null
        ? ResepDigital.fromJson(json['transaction_details']['resep_digital'])
        : null,
      catatanDokter: json['transaction_details']['catatan_dokter'] != null
        ? CatatanDokterModel.fromJson(json['transaction_details']['catatan_dokter'])
        : null,
      pasien: PasienModel.fromJson(json['transaction_details']['pasien']),
      antrian: AntrianModel.fromJson(json['transaction_details']['antrian']),
    );
  }
}





// var riwayattransaksi = [
//   RiwayatTransaksiModel(dokter: data_dokter[0], status: "Segera", tanggal: "2024-03-04", jam: "02:00:00.857"),
//   RiwayatTransaksiModel(dokter: data_dokter[1], status: "Selesai", tanggal: "2024-03-04", jam: "02:00:00.857"),
//   RiwayatTransaksiModel(dokter: data_dokter[2], status: "Batal", tanggal: "2024-03-04", jam: "02:00:00.857")
// ];