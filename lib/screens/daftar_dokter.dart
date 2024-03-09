// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rumah_sakit/components/bottomNavigasiBar.dart';
import 'package:rumah_sakit/components/datadokter.dart';

import 'package:rumah_sakit/screens/detail_pertemuan.dart';
import 'package:rumah_sakit/screens/catatan_dan_resep_dokter.dart';
import 'package:rumah_sakit/screens/rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable, camel_case_types
class daftar_dokter extends StatefulWidget {
  const daftar_dokter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _daftar_dokterState createState() => _daftar_dokterState();
}

var dokter = ["Semua", "Umum", "Anak", "Dalam"];
List<List<String>> data = [["Dr. Eki Rakhmah Z, Sp.A","Dokter Spesialis Anak","4.8","true",""],
["Dr. Yudi Heriyanto","Dokter Umum","4.2","false",""],
["Dr. Lilis","Dokter Umum","4.5","false",""],
["Dr. Rini wijaya. Sp.PD","Dokter Spesialis Dalam","4.8","false",""],
["Dr. Budi Santoso, Sp.A","Dokter Spesialis Anak","4.3","true",""]

];
List<List<String>> data2 = [["Dr. Eki Rakhmah Z, Sp.A","Dokter Spesialis Anak","4.8","true",""],
["Dr. Yudi Heriyanto","Dokter Umum","4.2","false",""],
["Dr. Lilis","Dokter Umum","4.5","false",""],
["Dr. Rini wijaya. Sp.PD","Dokter Spesialis Dalam","4.8","false",""],
["Dr. Budi Santoso, Sp.A","Dokter Spesialis Anak","4.3","true",""]

];
int selecteddokter = 0;
List<bool> _isLiked = [true, false, false, false, true];

// ignore: camel_case_types
class _daftar_dokterState extends State<daftar_dokter> {
  // ignore: non_constant_identifier_names
  List<int> posisi_data(){
    List<int> hasil = [];
    for(int i = 0; i < data.length; i++){
      if(selecteddokter == 0){
        hasil.add(i);
      }else if(cek(data[i]) == true){
        hasil.add(i);
      }
    }
    return hasil;
  }

  bool cek(List<String> test){
    if(test[1].toLowerCase().contains(dokter[selecteddokter].toLowerCase()) == true){
      return true;
    }else{
      return false;
    }
  }
  List<String> data_nama(){
    List<String> sem = [];
    for(int i = 0;i < data.length;i++){
      sem.add(data[i][0]);
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
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        ),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(data_nama()));
              },
            ),
          ],
        elevation: 10,
        shadowColor: Colors.white,
      ),
      backgroundColor: Colors.black.withOpacity(0.1),
      body: Column(children: [
        _katagori(),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 400,
          height: 680,
          child: ListView.separated(
            itemCount: posisi_data().length,
            itemBuilder: (BuildContext context, int index) {
              return datadokter(index: posisi_data()[index], data: data, isLiked: _isLiked,);
            }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 10,); },
          ),
        )
      ]),
    );
  }

  Material _datadokter(int index) {
    return Material(
              elevation: 5.0, // Nilai elevasi
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.white.withOpacity(0.0),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("assets/images/dokter_1.png"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index][0],style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(height: 10,),
                          Text(data[index][1],style: const TextStyle(
                            fontSize: 14,
                          ),),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              RatingBar.builder(
                              initialRating: double.parse(data[index][2]),
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
                              onRatingUpdate: (rating) { 
                              },
                              ignoreGestures: true,
                              ),
                              const SizedBox(width: 15,),
                              Text(data[index][2],style: const TextStyle(
                                fontSize: 14,
                              ),),
                              
                            ],
                          ),
                      ],),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          _isLiked[index] ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked[index] ? Colors.black : Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            _isLiked[index] = !_isLiked[index];
                          });
                        },
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
      margin: const EdgeInsets.only(top: 20, left: 10),
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


class DataSearch extends SearchDelegate<String> {
  final List<String> data; // Anda perlu mengisi list ini dengan data Anda

  DataSearch(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Anda bisa mengembalikan widget Anda di sini berdasarkan hasil pencarian
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : data.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemBuilder: (context, index) => datadokter(index: index, data: data2, isLiked: _isLiked),
      itemCount: suggestionList.length,
    );
  }
  
}