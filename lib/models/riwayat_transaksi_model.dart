import 'package:rumah_sakit/models/dokter_model.dart';
class RiwayatTransaksiModel{
    DokterModel dokter;
    String status;
    String tanggal;
    String jam;

    RiwayatTransaksiModel({
      required this.dokter,
      required this.status,
      required this.tanggal,
      required this.jam,
    });
}

// var riwayattransaksi = [
//   RiwayatTransaksiModel(dokter: data_dokter[0], status: "Segera", tanggal: "2024-03-04", jam: "02:00:00.857"),
//   RiwayatTransaksiModel(dokter: data_dokter[1], status: "Selesai", tanggal: "2024-03-04", jam: "02:00:00.857"),
//   RiwayatTransaksiModel(dokter: data_dokter[2], status: "Batal", tanggal: "2024-03-04", jam: "02:00:00.857")
// ];