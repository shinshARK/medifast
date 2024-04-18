class ArtikelModel{
  String judul;
  String foto;
  String isi;
  DateTime createdat;
  DateTime updatedat;


  ArtikelModel({
    required this.judul,
    required this.foto,
    required this.isi,
    required this.createdat,
    required this.updatedat
  });

}


// ignore: non_constant_identifier_names
var data_artikel = [
  // Data yang sudah ada
  ArtikelModel(judul: "judul1 ", foto: "a.png", isi: "isi1", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  ArtikelModel(judul: "judul2", foto: "b.png", isi: "isi2", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  ArtikelModel(judul: "judul3", foto: "c.png", isi: "isi3", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  ArtikelModel(judul: "judul4", foto: "d.png", isi: "isi4", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  ArtikelModel(judul: "judul5", foto: "e.png", isi: "isi5", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23))

  // ArtikelModel(judul: "judul6", foto: "f.png", isi: "isi6", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul7", foto: "g.png", isi: "isi7", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul8", foto: "h.png", isi: "isi8", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul9", foto: "i.png", isi: "isi9", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul10", foto: "j.png", isi: "isi10", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul11", foto: "k.png", isi: "isi11", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul12", foto: "l.png", isi: "isi12", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul13", foto: "m.png", isi: "isi13", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul14", foto: "n.png", isi: "isi14", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul15", foto: "o.png", isi: "isi15", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul16", foto: "p.png", isi: "isi16", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul17", foto: "q.png", isi: "isi17", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul18", foto: "r.png", isi: "isi18", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul19", foto: "s.png", isi: "isi19", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
  // ArtikelModel(judul: "judul20", foto: "t.png", isi: "isi20", createdat: DateTime.now(), updatedat: DateTime(2024, 5, 23)),
];
