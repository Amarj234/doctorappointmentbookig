import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:living/confirmpage/confirm_page.dart';
import 'package:http/http.dart' as http;
import '../bookdoctor/review_page.dart';
import '../servise.dart';
class PhysicianPage extends StatefulWidget {
  const PhysicianPage({Key? key, required this.drid}) : super(key: key);
final drid;
  @override
  State<PhysicianPage> createState() => _PhysicianPageState();
}

class _PhysicianPageState extends State<PhysicianPage> {



  void initState() {
    // TODO: implement initState
    super.initState();
    getanswer();
  }

  final search=TextEditingController();

bool isshow=true;
  Serves serves=Serves();
  List<dynamic> allans=[];
  getanswer() async{

    final uri = Uri.parse(serves.url+"showdoctor.php");
    var response = await http.post(uri,body: {
      'showdata':search.text.toString(),
      'drid':widget.drid,

    });

    var state= json.decode(response.body);
    allans=[];
    setState(() {
      isshow=false;
      allans=state;
    });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Your Health Concern',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        elevation: 0,
        centerTitle: true,

        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: search,
                      style: const TextStyle(
                        //height: 0.4,
                      ),
                      onChanged: (v){
                        getanswer();
                        setState(() {
                        });
                      },
                      enabled: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 40),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          border: OutlineInputBorder(
                              borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          hintText: ('Search Specialists'),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
        Container(
          child:isshow ? Center(child: CircularProgressIndicator()): allans.length==0 ? Center(child: Text('Data Not Found'),) :  Column(
            children: allans
                .map<Padding>((dynamic item) {
              //   print(item);
              return       Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color(0xFF42afc6),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          //color: Colors.teal,
                          child:  CircleAvatar(
                            radius: 50,
                            backgroundImage:
                            NetworkImage('${serves.url}image/${item['Photo']}'),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              item['name'].toString(),
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                             Text(
                              item['Degree'].toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                             Text(
                              '${item['Years_experience']} Years experience',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                             Text(
                              item['university_name'].toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                             Text(
                              item['Consultation'].toString(),
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),

                            Row(
                              children: [
                                Text(
                                  "Booking Type-",
                                  style: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  item['bookingtype'].toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                            updateOnDrag:false,
                                tapOnlyMode :false,
                                  ignoreGestures : false,
                                  initialRating: double.parse(item['star']),
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
                                TextButton(onPressed: (){
                                  Navigator.push(
                                    context,MaterialPageRoute(builder: (context)=> ReviewRating(drid: item['id'].toString(),)),
                                  );
                                }, child: Text('View',style: TextStyle(color: Colors.red),)),
                              ],
                            ),


                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>  CnfPage(did:item['id'],dname:item['name'],payment:item['Consultation'].toString(),type:item['bookingtype'])));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    'Book Now',
                                    style: TextStyle(
                                        color: Color(0xFF42afc6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );

            }).toList()
    ),
        )

            ],
          )),
    );
  }
}
