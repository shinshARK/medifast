class PasienModel{
   final int idPasien;
  final String namaPasien;
  final int umur;
  final String jenisKelamin;
  final String keluhan;
  final String alamat;


  PasienModel({
   required this.idPasien,
    required this.namaPasien,
    required this.umur,
    required this.jenisKelamin,
    required this.keluhan,
    required this.alamat,
  });

  factory PasienModel.fromJson(Map<String, dynamic> json) {
    return PasienModel(
      idPasien: json['id_pasien'],
      namaPasien: json['nama_pasien'],
      umur: json['umur'],
      jenisKelamin: json['jenis_kelamin'],
      keluhan: json['keluhan'],
      alamat: json['alamat'],
    );
  }

}

// var data_obat = [
//   PasienModel(namapasien: "Ilham Akbar", umur: 21, jenis_kelamin: "laki-laki", keluhan: "sakit perut", alamat: "jalan ciwaruga"),
//   PasienModel(namapasien: "Adrian Mulianto", umur: 21, jenis_kelamin: "laki-laki", keluhan: "mual dan pusing", alamat: "cilimus"),
//   PasienModel(namapasien: "Repan Dhia", umur: 21, jenis_kelamin: "laki-laki", keluhan: "batuk", alamat: "gerlong bawah"),
// ];
