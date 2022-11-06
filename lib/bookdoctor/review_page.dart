import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../servise.dart';

class ReviewRating extends StatefulWidget {
  const ReviewRating({Key? key,required this.drid}) : super(key: key);
final drid;

  @override
  State<ReviewRating> createState() => _ReviewRatingState();
}

class _ReviewRatingState extends State<ReviewRating> {



  Serves serves=Serves();

  bool isshow=true;

  List<dynamic> allans=[];
  getanswer() async{

    final uri = Uri.parse(serves.url+"review.php?showdata=${widget.drid}");
    print(uri);
    var response = await http.get(uri);

    var state= json.decode(response.body);

    allans=[];
    setState(() {
      allans=state;
      isshow=false;
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
        title: Text(
          'Rating Review',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: Card(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: allans.map((edata) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("${serves.url}image/${edata['usid']}.jpg"),
                    ),
                    title: Text(
                      edata['name'].toString(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: RatingBar.builder(
                      initialRating: double.parse(edata['star']),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: EdgeInsets.symmetric(horizontal:1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,

                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),

                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(60, 0, 10, 10),
                    child: Text(
                        edata['comment'].toString()),
                  )
                ],
              );

            }).toList(),
          )
      ),
    );
  }
}
