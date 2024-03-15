import 'package:flutter/material.dart';

class NotifikasiModel{
  String keterangan;
  String tanggal;
  IconData icon;
  bool status;
  String selisih;


  NotifikasiModel({
    required this.keterangan,
    required this.tanggal,
    required this.icon,
    required this.status,
    required this.selisih
  });


  void updatewaktu(String newValue) {
    selisih = newValue;
  }
}
DateTime waktuSekarang = DateTime.now();
DateTime kemarin = waktuSekarang.subtract(const Duration(days: 1));
DateTime mingguIni = waktuSekarang.subtract(const Duration(days: 3));
DateTime semingguLebih = waktuSekarang.subtract(const Duration(days: 8));

var datanotifikasi = [
  NotifikasiModel(keterangan: "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi", tanggal: waktuSekarang.toString(), icon: Icons.medication_liquid_outlined, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!", tanggal: waktuSekarang.subtract(const Duration(hours: 2)).toString(), icon: Icons.calendar_month, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Waktu untuk check-up rutin!", tanggal: waktuSekarang.subtract(const Duration(hours: 4)).toString(), icon: Icons.calendar_month, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi", tanggal: kemarin.toString(), icon: Icons.medication_liquid_outlined, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!", tanggal: kemarin.subtract(const Duration(hours: 2)).toString(), icon: Icons.calendar_month, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Waktu untuk check-up rutin!", tanggal: kemarin.subtract(const Duration(hours: 4)).toString(), icon: Icons.calendar_month, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi", tanggal: mingguIni.toString(), icon: Icons.medication_liquid_outlined, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!", tanggal: mingguIni.subtract(const Duration(days: 1)).toString(), icon: Icons.calendar_month, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Resep digital sudah dapat kamu lihat pada halaman\nRiwayat Transaksi", tanggal: semingguLebih.toString(), icon: Icons.medication_liquid_outlined, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Jangan lupa untuk minum Obat Paracetamol 2 x 3\nSesudah Makan!", tanggal: semingguLebih.subtract(const Duration(days: 1)).toString(), icon: Icons.calendar_month, status: false,selisih: ""),
  NotifikasiModel(keterangan: "Waktu untuk check-up rutin!", tanggal: semingguLebih.subtract(const Duration(days: 2)).toString(), icon: Icons.calendar_month, status: false,selisih: ""),
];
