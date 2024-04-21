import 'dart:convert';

import 'package:intl/intl.dart';

class Article{
  String title;
  String photo;
  String content;
  DateTime createdat;
  DateTime updatedat;


  Article({
    required this.title,
    required this.photo,
    required this.content,
    required this.createdat,
    required this.updatedat
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    return Article(
      title: json['title'],
      photo: json['photo'],
      content: json['content'].toString().replaceAll('\\n', '\n'),
      createdat: format.parse(json['createdat']),
      updatedat: format.parse(json['updatedat']),
    );
  }
}




// // ignore: non_constant_identifier_names
// var data_artikel = [
//   // Data yang sudah ada
//   Article(title: "title1 ", photo: "a.png", content: "content1", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   Article(title: "title2", photo: "b.png", content: "content2", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   Article(title: "title3", photo: "c.png", content: "content3", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   Article(title: "title4", photo: "d.png", content: "content4", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   Article(title: "title5", photo: "e.png", content: "content5", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23))

//   // Article(title: "title6", photo: "f.png", content: "content6", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title7", photo: "g.png", content: "content7", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title8", photo: "h.png", content: "content8", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title9", photo: "i.png", content: "content9", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title10", photo: "j.png", content: "content10", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title11", photo: "k.png", content: "content11", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title12", photo: "l.png", content: "content12", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title13", photo: "m.png", content: "content13", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title14", photo: "n.png", content: "content14", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title15", photo: "o.png", content: "content15", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title16", photo: "p.png", content: "content16", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title17", photo: "q.png", content: "content17", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title18", photo: "r.png", content: "content18", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title19", photo: "s.png", content: "content19", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
//   // Article(title: "title20", photo: "t.png", content: "content20", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
// ];
