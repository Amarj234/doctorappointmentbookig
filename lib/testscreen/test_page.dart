import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:living/bookpage/book_page.dart';
import 'package:living/family/family_page.dart';
import 'package:http/http.dart' as http;
import '../servise.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  void initState() {
    // TODO: implement initState
    super.initState();
    getanswer();
    getanswer1();
  }
  String? reg;
  String? name;
  String? gender;
  String? image;
  List<dynamic> allans=[];
  getanswer1() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    reg=prefs.getString('regid');
    final uri = Uri.parse(serves.url+"member.php");
    var response = await http.post(uri,body: {
      'showdata':prefs.get('regid').toString(),


    });

    var state= json.decode(response.body);

    setState(() {
    allans=state;


    });

  }

  Serves serves=Serves();

  getanswer() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"showdoctor.php");
    var response = await http.post(uri,body: {
      'selfdata':prefs.get('regid').toString(),


    });

    var state= json.decode(response.body);

    setState(() {
      name=state[0]['cfname'];
      gender=state[0]['gender'];
      image=state[0]['gender'];


    });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: name==null ? Center(child: CircularProgressIndicator(),): Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundImage: const AssetImage('assets/images/family.jpg'),
                radius: 50,
                backgroundColor: Colors.blue[800],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                'Family Member',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                'Select your family member',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              // padding: EdgeInsets.only(top:50),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),),

                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      //color: Colors.blue,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundImage:
                          const AssetImage('assets/images/avatar.jpg'),
                          radius: 30,
                          backgroundColor: Colors.blue[800],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            name.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Self | Male | 28-June-2022',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
            const SizedBox(height: 30,),
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FamilyPage()));
                },
                child: const Text(
                  'Add Family Member',
                  style: TextStyle(fontSize: 14, color:Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>  BookPage(usid:reg.toString(),mid:'0')));
                },
                child: const Text(
                  'Proceed',
                  style: TextStyle(fontSize: 14, color:Colors.white),
                ),
              ),
            ),
SizedBox(height: 20,),
            Expanded(
              child: Container(
                child: ListView(
                  children: allans.map<ListTile>((e) {
                    return  ListTile(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => BookPage(usid:e['usid'],mid:e['id'])),
                        );
                      },
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(e['fullname'].toString(),style: TextStyle(fontSize: 20),),
                          Text(e['mobile'].toString(),style: TextStyle(fontSize: 12),),
                        ],
                      ),
                      leading: Image.asset("assets/images/booking.png"),
                      trailing: Text('${e['relation']} '),
                    );

                  }).toList(),
                ),
              ),
            )





          ],
        ),
      ),
    );
  }
}
