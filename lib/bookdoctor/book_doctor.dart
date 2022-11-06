import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:living/generalphysician/ganeral_physician.dart';
import 'package:living/navigatescreen/home_page.dart';
import 'package:http/http.dart' as http;
import '../servise.dart';


class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

  void initState() {
    // TODO: implement initState
    super.initState();

    getanswer();
  }

  final search=TextEditingController();


  Serves serves=Serves();
  List<dynamic> allans=[];
  getanswer() async{

    final uri = Uri.parse(serves.url+"category.php");
    print(uri);
    var response = await http.post(uri,body: {
      'showdata':search.text.toString(),


    });

    var state= json.decode(response.body);
    allans=[];
    setState(() {
      allans=state;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Find Your Health Concern',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),

          backgroundColor:Colors.teal
      ),
      body: SafeArea(


              child: Column(
                children: [

                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: search,
                          style: const TextStyle(
                            //  height: 0.4,
                          ),
                          onChanged: (v){
                            getanswer();
                            setState(() {
                            });
                          },
                          enabled: true,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: ('Search Symptoms/ Specialists'),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              )),
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Specialists Doctor',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),

                  Expanded(
                    child:allans.length==0 ? Center(child: CircularProgressIndicator()):  GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      children:allans
                          .map<InkWell>((dynamic item) {
                        //   print(item);
                        return     InkWell(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => PhysicianPage(drid:item['menu_id'])),
                            );

                          },
                          child: Container(

                            height:  MediaQuery.of(context).size.height/5,
                            width:   MediaQuery.of(context).size.width/2.2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage('${serves.url}../image/service/${item['menu_image']}'),
                                  ),

                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    item['menu'].toString(),style: TextStyle(fontSize: 12,color: Colors.black),),

                                ],

                              ),
                            ),

                          ),
                        );

                      }).toList(),
                    ),
                  ),
                ],
              ),



      ),
    );
  }
}
