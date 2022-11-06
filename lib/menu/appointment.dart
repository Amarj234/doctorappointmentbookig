import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:living/bookdoctor/book_doctor.dart';
import 'package:http/http.dart' as http;
import '../bookdoctor/reviewshow.dart';
import '../servise.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {


  void initState() {
    // TODO: implement initState
    super.initState();
    getanswer();
  }

  final search=TextEditingController();

  Serves serves=Serves();
  List<dynamic> allans=[];
  getanswer() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"myappointment.php");
    //print(uri);
    var response = await http.post(uri,body: {
      'showdata':prefs.getString('regid').toString(),

    });

    var state= json.decode(response.body);
    allans=[];
    setState(() {
      allans=state;
    });
print(state);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'My Appointment',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(

            children: allans.map((row)  {
              return  Padding(
                padding: const EdgeInsets.all(20.0),
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
                          child:  CircleAvatar(
                            radius: 50,
                            backgroundImage:
                            NetworkImage('${serves.url}image/${row['Photo']}'),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            row['name'].toString(),
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           Text(
                            row['Degree'].toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           
                           Row(
                             children: [
                               Text(
                                'Patient Name-',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                               Text(
                                 row['pname'],
                                 style: TextStyle(color: Colors.black),
                               ),
                             ],
                           ),
                          const SizedBox(
                            height: 5,
                          ),
                           Row(
                             children: [
                               Text(
                                "Age-",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                               Text(
                                 row['age'],
                                 style: TextStyle(color: Colors.black),
                               ),

                               SizedBox(width: 20,),

                               row['status']==1?  ElevatedButton(onPressed: (){
                                 Navigator.push(
                                   context, MaterialPageRoute(builder: (context) => ReviewPage(drid: row['doctorid'].toString(), image: "${serves.url}image/${row['Photo']}",name:row['name'])),
                                 );
                               }, child: Text('View'))
                               :Container(),
                             ],
                           ),
                          const SizedBox(
                            height: 5,
                          ),
                           Row(
                             children: [
                               Text(
                                'Fee:-Rs',
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                               Text(
                                 '${row['payment']}-',
                                 style: TextStyle(
                                     color: Colors.black,),
                               ),
                             ],
                           ),
                          const SizedBox(
                            height: 8,
                          ),
                           Row(
                             children: [
                               Text(
                                 'Booking Date-',
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                               Text(
                                 '${row['bdate']}',
                                 style: TextStyle(
                                     color: Colors.black, ),
                               ),
                             ],
                           ),
                          Row(
                            children: [
                              Text(
                                'Booking time-',
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${row['btime']}',
                                style: TextStyle(
                                    color: Colors.black, ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Booking Type-',
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${row['type']}',
                                style: TextStyle(
                                    color: Colors.black,),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Status-',
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              row['status']==2.toString()? Text(
              'Panding',
                style: TextStyle(
                  color: Colors.black,),
              ):  Text(
                                'Completed ',
                                style: TextStyle(
                                  color: Colors.black,),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              );

            }).toList(),
          ),
        ),
      ),
    );
  }
}
