import 'package:flutter/material.dart';
import 'package:rumah_sakit/models/dokter_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DataSearch extends SearchDelegate<String> {
  List<DokterModel> data;

  DataSearch(this.data);

  int pencarianindex(String nama) {
    int index = 0;
    while (data_dokter.length > index) {
      if (data_dokter[index].nama == nama) {
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
                .where(
                    (p) => p.nama.toLowerCase().contains(query.toLowerCase()))
                .toList();

        return ListView.separated(
            itemBuilder: (context, index) {
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
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                                'assets/images/${suggestionList[index].image}'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              suggestionList[index].nama,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              suggestionList[index].spesialis,
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
                                      double.parse(suggestionList[index].rating),
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
                                  suggestionList[index].rating,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            suggestionList[index].tanda
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: suggestionList[index].tanda
                                ? Colors.black
                                : Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              suggestionList[index].tanda
                                  ? suggestionList[index].setTanda(false)
                                  : suggestionList[index].setTanda(true);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: suggestionList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            });
      },
    );
  }
}
