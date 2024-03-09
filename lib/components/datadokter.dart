import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class datadokter extends StatefulWidget {
  final int index;
  final List<List<String>> data;
  final List<bool> isLiked;

  datadokter({required this.index, required this.data, required this.isLiked});

  @override
  _datadokterState createState() => _datadokterState();
}

class _datadokterState extends State<datadokter> {
  
  int index = 0;
  List<List<String>> data = [[]];
  List<bool> _isLiked = [];
  void initState() {
    super.initState();
    index = widget.index;
    data = widget.data;
    _isLiked = widget.isLiked;
  }
  Widget build(BuildContext context) {
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
                  // Anda perlu mengubah ini jika Anda ingin merubah _isLiked
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
