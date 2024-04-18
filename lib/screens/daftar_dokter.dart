// ignore: file_names
import 'package:flutter/material.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:rumah_sakit/screens/datasearch.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable, camel_case_types
class daftar_dokter extends StatefulWidget {
  const daftar_dokter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _daftar_dokterState createState() => _daftar_dokterState();
}

var dokter = ["Semua", "Umum", "Anak", "Dalam"];

int selecteddokter = 0;

// ignore: camel_case_types
class _daftar_dokterState extends State<daftar_dokter> {
  // ignore: non_constant_identifier_names
  List<int> posisi_data() {
    List<int> hasil = [];

    for (int i = 0; i < data_dokter.length; i++) {
      if (selecteddokter == 0) {
        hasil.add(i);
      } else if (data_dokter[i]
              .spesialis
              .toLowerCase()
              .contains(dokter[selecteddokter].toLowerCase()) ==
          true) {
        hasil.add(i);
      }
    }

    return hasil;
  }

  List<String> daftarnama() {
    List<String> sem = [];
    for (DokterModel temp in data_dokter) {
      sem.add(temp.nama);
    }
    return sem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigasiBar(inputan: 2),
      appBar: AppBar(
        title: const Text(
          'Dokter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                showSearch(context: context, delegate: DataSearch(data_dokter));
              });
            },
          ),
        ],
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: Column(children: <Widget>[
        _katagori(),
        Expanded(
          child: ListView.separated(
            itemCount: posisi_data().length,
            itemBuilder: (BuildContext context, int index) {
              return listdokter(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 30,
              );
            },
          ),
        )
      ]),
    );
  }

  Padding listdokter(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 5.0, // Nilai elevasi
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child: CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white.withOpacity(0.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/images/${data_dokter[posisi_data()[index]].image}'),
                ),
              ),
            ),
            
            Container(
              
              margin: const EdgeInsets.only(top: 23,left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data_dokter[posisi_data()[index]].nama,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    data_dokter[posisi_data()[index]].spesialis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: double.parse(
                            data_dokter[posisi_data()[index]].rating),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        //itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 1.0,
                        ),
                        // ignore: avoid_types_as_parameter_names
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        data_dokter[posisi_data()[index]].rating,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    data_dokter[posisi_data()[index]].favorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: data_dokter[posisi_data()[index]].favorite
                        ? Colors.black
                        : Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      data_dokter[posisi_data()[index]].favorite
                          ? data_dokter[posisi_data()[index]].setTanda(false)
                          : data_dokter[posisi_data()[index]].setTanda(true);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _katagori() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (index == 0) {
                      selecteddokter = 0;
                    } else if (index == 1) {
                      selecteddokter = 1;
                    } else if (index == 2) {
                      selecteddokter = 2;
                    } else if (index == 3) {
                      selecteddokter = 3;
                    } else if (index == 4) {
                      selecteddokter = 4;
                    }
                  });
                },
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: selecteddokter == index
                          ? const Color.fromARGB(255, 135, 203, 198)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: selecteddokter != index
                          ? Border.all(
                              color: const Color.fromARGB(
                                  255, 135, 203, 198), // Warna border
                              width: 3.0, // Ketebalan border
                            )
                          : null),
                  child: Text(
                    dokter[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selecteddokter == index
                            ? Colors.white
                            : const Color.fromARGB(255, 135, 203, 198),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: dokter.length),
    );
  }
}
