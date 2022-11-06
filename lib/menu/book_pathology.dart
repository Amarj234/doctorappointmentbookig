import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../servise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookPathology extends StatefulWidget {
  const BookPathology({Key? key}) : super(key: key);

  @override
  State<BookPathology> createState() => _BookPathologyState();
}

class _BookPathologyState extends State<BookPathology> {

  Serves serves=Serves();
  List<dynamic> allans=[];
  getanswer() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"showbookservice.php");
    var response = await http.post(uri,body: {
      'showdata':prefs.getString('regid'),


    });

    var state= json.decode(response.body);
    print(state);
    allans=[];
    setState(() {
      allans=state;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getanswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Book Pathology Test',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: allans.map((row) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Color(0xFFeee9e9),

                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            //color: Colors.teal,
                            child: Image.network("${serves.url}image/${row['img']}"),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  row['Adv'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Member-${row['membername']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  row['text1'].toString(),
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  row['text1'].toString(),
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  '10:00 Am - 5:30',
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  "Price- ${row['pos_ad']}",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

          }).toList(),
        ),
      ),
    );
  }
}
