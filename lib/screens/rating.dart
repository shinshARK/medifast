import 'package:flutter/material.dart';

// ignore: camel_case_types
class rating extends StatefulWidget {
  const rating({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ratingState createState() => _ratingState();
}

// ignore: camel_case_types
class _ratingState extends State<rating> {
  int rating = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Nilai', style: TextStyle(fontWeight: FontWeight.w700)),
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 25.0), 
            child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF00A8A8), 
                  borderRadius: BorderRadius.circular(20), 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15), 
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/dokter_4.png',
                            fit: BoxFit
                                .cover, 
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              10), 
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Dr. Eki Rakhmah Z., Sp.A",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold, 
                            ),
                          ),
                          Text(
                            "Dokter Spesialis Anak",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 25.0, top: 25.0),
              child: Text(
                "Rating",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily:
                      'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Row(
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipRRect(
                    borderRadius: index == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          )
                        : index == 4
                            ? const BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              )
                            : BorderRadius.circular(0.0),
                    child: Container(
                      color: const Color(0xFFF2F4F7),
                      child: IconButton(
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: index < rating
                              ? Colors.yellow
                              : Colors.grey, 
                        ),
                        onPressed: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          ListTile(
            title: const Padding(
              padding: EdgeInsets.only(
                  left: 10.0),
              child: Text(
                "Ulasan",
                style: TextStyle(
                  fontSize: 20.0, 
                  color: Colors.black, 
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F7), 
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) {
                     
                    },
                    style: const TextStyle(
                      color: Color(0xFF344154), 
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    cursorColor:
                        const Color(0xFF00A8A8), 
                  )),
            ),
          )
        ],
      ),
      bottomNavigationBar: _BottomNavigasiBar(context),
    );
  }

  // ignore: non_constant_identifier_names
  BottomAppBar _BottomNavigasiBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 350,
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 135, 203, 198),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4.9,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: const Text(
            'Simpan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
