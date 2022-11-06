import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../servise.dart';
class ReviewPage extends StatefulWidget {
   ReviewPage({Key? key,required this.drid,required this.name,required this.image,}) : super(key: key);
final drid ,name ,image;
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  Serves serves=Serves();
  addtocart() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    print('addtocart');
    final uri = Uri.parse(serves.url+"review.php");
    var response = await http.post(uri,body: {
      'usid':prefs.getString('regid').toString(),
      'drid':widget.drid.toString(),
      'cmnt':comment.text,
      "star":ratings.toString(),

    });
    if (response.statusCode == 200) {
      var check = jsonDecode(response.body);
      print(" $check");
      if (check == 1) {
        getanswer();
      }

    }

  }

  final comment =TextEditingController();

  bool isshow=true;

  List<dynamic> allans=[];
  getanswer() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"review.php");
    var response = await http.post(uri,body: {
      'check':prefs.getString('regid'),
      'showdata':widget.drid.toString(),
    });

    var state= json.decode(response.body);
    print(state);
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
    ratings=4;
    getanswer();
  }


  double? ratings;

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
      body: SingleChildScrollView(
        child:isshow?Center(child: CircularProgressIndicator()): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 10,
                child: Container(
                  child:allans.length==0 ? Column(
                    children: [ ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                      title: Text(
                        widget.name.toString(),
                        style:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RatingBar.builder(
                          initialRating: 4,
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
                            ratings=rating ;

                          },
                        ),
                      ),
                    ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.fromLTRB(30,0, 30, 30),
                        child: TextField(
                          controller: comment,
                          minLines: 5,
                          maxLines: 5,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              hintText: ('comment'),
                              contentPadding: EdgeInsets.only(left: 10,top: 10)
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        print(ratings);
                       addtocart();
                      }, child:Text('Submit'))],
                  ) :Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: allans.map((edata) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(widget.image),
                            ),
                            title: Text(
                              widget.name,
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
                            trailing: IconButton(onPressed: (){
                              setState(() {
                                allans[0]['comment'];
                                allans=[];
                              });

                            },icon: Icon(Icons.edit),),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(60, 0, 10, 10),
                            child: Text(
                                edata['comment'].toString()),
                          )
                        ],
                      );

                    }).toList(),
                  )   ,
                ),

              ),
            ),




          ],
        ),
      ),
    );
  }
}
