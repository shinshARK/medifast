import 'package:flutter/material.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rumah_sakit/screens/informasi_dokter.dart';



class DataSearch extends SearchDelegate<String> {
  List<DokterModel> data;
  List<DokterModel> data_dokter = [];
  DataSearch(this.data,this.data_dokter);

  int pencarianindex(String nama) {
    int index = 0;
    while (data_dokter.length > index) {
      if (data_dokter[index].name == nama) {
        break;
      } else {
        index += 1;
      }
    }
    return index;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
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
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        final suggestionList = query.isEmpty
    ? data
    : data
        .where((p) => p.name != null && p.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();


        return ListView.separated(
            itemBuilder: (context, index) {
              return listdokter(suggestionList, index, setState,context);
            },
            itemCount: suggestionList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 30,
              );
            });
      },
    );
  }

  Padding listdokter(
      List<DokterModel> suggestionList, int index, StateSetter setState,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => informasi_dokter(
                    key: ValueKey(suggestionList[index].name),
                    id: suggestionList[index].id,
                  ),
                ),
              );
        },
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
                        'assets/images/${suggestionList[index].photo}'),
                  ),
                ),
              ),
              
              Container(
                
                margin: const EdgeInsets.only(top: 23,left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestionList[index].name ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      suggestionList[index].specialty ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating:
                              double.parse(suggestionList[index].rating ?? ''),
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
                          suggestionList[index].rating ?? '',
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
                      suggestionList[index].favorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          suggestionList[index].favorite ? Colors.black : Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        suggestionList[index].favorite
                            ? suggestionList[index].setTanda(false)
                            : suggestionList[index].setTanda(true);
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
