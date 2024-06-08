class DokterModel {
  int? id;
  String? name;
  String? photo;
  String? specialty;
  String? rating;
  bool favorite;
  int? experience;
  String? about;
  String? schedule;

  DokterModel(
      {
        required this.name,
        required this.photo,
        required this.specialty,
        required this.rating,
        required this.favorite,
        required this.experience,
        required this.about,
        required this.schedule
      });

  void setTanda(bool newValue) {
    favorite = newValue;
  }

  factory DokterModel.fromJson(Map<String, dynamic> json) {
    return DokterModel(
        name: json['name'],
        photo: json['photo'],
        specialty: json['specialty'],
        rating: json['rating'],
        favorite: json.containsKey('favorite') ? json['favorite'] : false,
        experience: json['experience'],
        about: json['about'],
        schedule: json['schedule']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo': photo,
      'specialty': specialty,
      'rating': rating,
      'favorite': favorite,
      'experience': experience,
      'about': about,
      'schedule': schedule
    };
  }
}

// ignore: non_constant_identifier_names
// var data_dokter = [
//   // Data yang sudah ada
//   DokterModel(
//       nama: "Dr. Eki Rakhmah Z, Sp.A",
//       spesialis: "Dokter Anak",
//       rating: "4.8",
//       favorite: true,
//       image: "dokter_1.png",
//       pengalaman: 1,
//       tentang: "apa ini 1",
//       jadwal: "senin, 07:00 - 08:00"),
//   DokterModel(
//       nama: "Dr. Yudi Heriyanto",
//       spesialis: "Dokter Umum",
//       rating: "4.2",
//       favorite: false,
//       image: "dokter_4.png",
//       pengalaman: 2,
//       tentang: "apa ini 2",
//       jadwal: "selasa, 07:00 - 08:00"),
//   DokterModel(
//       nama: "Dr. Rina wijaya, Sp.PD",
//       spesialis: "Dokter Dalam",
//       rating: "4.8",
//       favorite: false,
//       image: "dokter_2.png",
//       pengalaman: 10,
//       tentang: "apa ini 3",
//       jadwal: "rabu, 07:00 - 08:00"),
//   DokterModel(
//       nama: "Dr. Budi Santoso, Sp.A",
//       spesialis: "Dokter Anak",
//       rating: "4.3",
//       favorite: true,
//       image: "dokter_5.png",
//       pengalaman: 11,
//       tentang: "apa ini 4",
//       jadwal: "kamis, 07:00 - 08:00"),
//   DokterModel(
//       nama: "Dr. Lilis",
//       spesialis: "Dokter Umum",
//       rating: "4.5",
//       favorite: false,
//       image: "dokter_3.png",
//       pengalaman: 5,
//       tentang: "apa ini 5",
//       jadwal: "jumat, 07:00 - 08:00")

//   // DokterModel(nama: "Dr. Dummy 1",spesialis: "Dokter Anak",rating: "4.1",favorite: true,image: "dokter_6.png", pengalaman: 3, tentang: "apa ini 6", jadwal: "senin, 09:00 - 10:00"),
//   // DokterModel(nama: "Dr. Dummy 2",spesialis: "Dokter Umum",rating: "4.2",favorite: false,image: "dokter_7.png", pengalaman: 4, tentang: "apa ini 7", jadwal: "selasa, 09:00 - 10:00"),
//   // DokterModel(nama: "Dr. Dummy 3",spesialis: "Dokter Dalam",rating: "4.3",favorite: false,image: "dokter_8.png", pengalaman: 5, tentang: "apa ini 8", jadwal: "rabu, 09:00 - 10:00"),
//   // DokterModel(nama: "Dr. Dummy 4",spesialis: "Dokter Anak",rating: "4.4",favorite: true,image: "dokter_9.png", pengalaman: 6, tentang: "apa ini 9", jadwal: "kamis, 09:00 - 10:00"),
//   // DokterModel(nama: "Dr. Dummy 5",spesialis: "Dokter Umum",rating: "4.5",favorite: false,image: "dokter_10.png", pengalaman: 7, tentang: "apa ini 10", jadwal: "jumat, 09:00 - 10:00"),
//   // DokterModel(nama: "Dr. Dummy 6",spesialis: "Dokter Anak",rating: "4.6",favorite: true,image: "dokter_11.png", pengalaman: 8, tentang: "apa ini 11", jadwal: "senin, 11:00 - 12:00"),
//   // DokterModel(nama: "Dr. Dummy 7",spesialis: "Dokter Umum",rating: "4.7",favorite: false,image: "dokter_12.png", pengalaman: 9, tentang: "apa ini 12", jadwal: "selasa, 11:00 - 12:00"),
//   // DokterModel(nama: "Dr. Dummy 8",spesialis: "Dokter Dalam",rating: "4.8",favorite: false,image: "dokter_13.png", pengalaman: 10, tentang: "apa ini 13", jadwal: "rabu, 11:00 - 12:00"),
//   // DokterModel(nama: "Dr. Dummy 9",spesialis: "Dokter Anak",rating: "4.9",favorite: true,image: "dokter_14.png", pengalaman: 11, tentang: "apa ini 14", jadwal: "kamis, 11:00 - 12:00"),
//   // DokterModel(nama: "Dr. Dummy 10",spesialis: "Dokter Umum",rating: "5.0",favorite: false,image: "dokter_15.png", pengalaman: 12, tentang: "apa ini 15", jadwal: "jumat, 11:00 - 12:00"),
//   // DokterModel(nama: "Dr. Dummy 11",spesialis: "Dokter Anak",rating: "4.1",favorite: true,image: "dokter_16.png", pengalaman: 13, tentang: "apa ini 16", jadwal: "senin, 13:00 - 14:00"),
//   // DokterModel(nama: "Dr. Dummy 12",spesialis: "Dokter Umum",rating: "4.2",favorite: false,image: "dokter_17.png", pengalaman: 14, tentang: "apa ini 17", jadwal: "selasa, 13:00 - 14:00"),
//   // DokterModel(nama: "Dr. Dummy 13",spesialis: "Dokter Dalam",rating: "4.3",favorite: false,image: "dokter_18.png", pengalaman: 15, tentang: "apa ini 18", jadwal: "rabu, 13:00 - 14:00"),
//   // DokterModel(nama: "Dr. Dummy 14",spesialis: "Dokter Anak",rating: "4.4",favorite: true,image: "dokter_19.png", pengalaman: 16, tentang: "apa ini 19", jadwal: "kamis, 13:00 - 14:00"),
//   // DokterModel(nama: "Dr. Dummy 15",spesialis: "Dokter Umum",rating: "4.5",favorite: false,image: "dokter_20.png", pengalaman: 17, tentang: "apa ini 20", jadwal: "jumat, 13:00 - 14:00"),
// ];
