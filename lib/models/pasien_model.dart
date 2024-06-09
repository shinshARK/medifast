class PasienModel{
  String namapasien;
  int umur;
  String jenis_kelamin;
  String keluhan;
  String alamat;


  PasienModel({
    required this.namapasien,
    required this.umur,
    required this.jenis_kelamin,
    required this.keluhan,
    required this.alamat,
  });

}

var data_obat = [
  PasienModel(namapasien: "Ilham Akbar", umur: 21, jenis_kelamin: "laki-laki", keluhan: "sakit perut", alamat: "jalan ciwaruga"),
  PasienModel(namapasien: "Adrian Mulianto", umur: 21, jenis_kelamin: "laki-laki", keluhan: "mual dan pusing", alamat: "cilimus"),
  PasienModel(namapasien: "Repan Dhia", umur: 21, jenis_kelamin: "laki-laki", keluhan: "batuk", alamat: "gerlong bawah"),
];
