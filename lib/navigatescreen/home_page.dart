import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:living/bookdoctor/book_doctor.dart';
import 'package:living/menu/appointment.dart';
import 'package:living/menu/book_pathology.dart';
import 'package:living/menu/consult_page.dart';
import 'package:living/menu/my_doctor.dart';
import 'package:living/menu/setting_page.dart';
import 'package:living/navigatescreen/help.dart';
import 'package:living/testscreen/test_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../bookpage/store_page.dart';
import '../screen/login_page.dart';
import '../screen/profile.dart';
import '../servise.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share/flutter_share.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void initState() {
    super.initState();
 checksesiion();
    getanswer();
    getbanner();
  }
  String? topimag;
  String? buttomimag;

  getbanner() async{

    final uri = Uri.parse(serves.url+"banner.php");
    var response = await http.post(uri,body: {
      'showdata':'',


    });

    var state= json.decode(response.body);
 //   print(state);
    setState(() {
topimag =state[0]['topimg'];
buttomimag =state[0]['buttomimg'];
    });
//print("${serves.url}../image/banner/$buttomimag");
  }



  String? proimage;
  String? name;
  String? email;
  checksesiion()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"getuser.php");
    var response = await http.post(uri,body: {
      'showdata':prefs.getString('regid'),

    });

    var state= json.decode(response.body);
    setState((){
      name=prefs.getString('user');
      email=state[0]['cemail'];
      proimage="${serves.url}image/${state[0]['reg_id']}.jpg";
    });
//print('drower');
   // name=prefs.getString('')
  }


  Serves serves=Serves();
  List<dynamic> allans=[];
  getanswer() async{

    final uri = Uri.parse(serves.url+"showbloc.php");
    var response = await http.post(uri,body: {
      'showdata':'',
    });

    var state= json.decode(response.body);

    allans=[];
    setState(() {
      allans=state;
    });

  }



  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async{
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;

        SystemNavigator.pop();


    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        backgroundColor: Colors.teal,
        actions:  [
          InkWell(
            onTap: (){

              Navigator.push(
                context,MaterialPageRoute(builder: (context)=> StorePage()),
              );
            },
            child: Icon(
              Icons.shopping_cart_checkout_sharp,
              color: Colors.white,
              size: 25,
            ),
          )
        ],

        title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.teal,
            child: Center(
              child: Text("Livingroots-Diagnostic",style: TextStyle(fontSize: 15),
              ),
            )),
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFC8E6C9),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                padding: EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                  accountName: Text(name.toString(),style: TextStyle(color: Colors.black),),
                  accountEmail: Row(
                    children: [
                      Text(email.toString(),style: TextStyle(color: Colors.black),),
                       SizedBox(width: 10,),
                       InkWell(
                           onTap: (){
                             Navigator.push(context,
                                 MaterialPageRoute(builder: (_) => const Profile()));
                           },

                           child: Icon(Icons.edit))
                    ],
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(proimage.toString()),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFC8E6C9),
                  ),
                ),
              ),
              // ListTile(
              //   leading: Image.asset(
              //     'assets/images/my.png',color: Colors.black,
              //     height: 20,
              //     width: 20,
              //   ),
              //   title: const Text("My Doctor"),
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (_) => const MyDoctor()));
              //   },
              // ),
              ListTile(
                leading: Image.asset(
                  'assets/images/microscope.png',
                  height: 20,
                  width: 20,
                  color: Colors.black,
                ),
                title: const Text("Book Pathology"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const BookPathology()));
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/user.png',
                  height: 20,
                  width: 20,
                  color: Colors.black,
                ),
                title: const Text("Appointments"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Appointment()));
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.black,
                ),
                title: const Text("Privacy & Policy"),
                onTap: () async{
                  await launchUrl(Uri.parse('https://lrdiagnostic.com/privacy-policy.php'));
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.help,
                  color: Colors.black,
                ),
                title: const Text("Terms & Condition"),
                onTap: () async{
                  await launchUrl(Uri.parse('https://lrdiagnostic.com/terms-condition.php'));
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                title: const Text("Share with friends"),
                onTap: () async{
                  await FlutterShare.share(
                      title: 'Example share',
                      text: 'Book Home Collection',
                      linkUrl: 'https://play.google.com/store/apps/details?id=com.partner.livingpannel',
                      chooserTitle: 'Health Packages Our facility implements best practices and quality standards, making us one of the best renowned diagnostic labs.');
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.star_rate,
                  color: Colors.black,
                ),
                title: const Text("Rate us"),
                onTap: () async{
                  await launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.partner.livingpannel'));
                },
              ),



              ListTile(
                leading: const Icon(
                  Icons.help_outline,
                  color: Colors.black,
                ),
                title: const Text("Help Center"),

                  onTap: () async{
                    await launchUrl(Uri.parse('https://lrdiagnostic.com/contact-us.php'));

                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: const Text("Log Out"),
                onTap: () async{
                  SharedPreferences prefs =await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context)=> LoginPage()),
                  );

                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFeee9e9),
      body: WillPopScope(
        onWillPop: onWillPop ,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  // color: Color(0xFFeee9e9),
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    //color: Colors.teal,
                    child: Image.network("${serves.url}../image/banner/$topimag"),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'WE TAKE\nCARE OF',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        const Text(
                          'YOUR HEALTH',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const TestPage()));
                  },
                  child: Container(
                    // padding: const EdgeInsets.only(left: 20, top: 60),
                    child: const CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage('assets/images/a.jpg'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const DoctorPage()));
                  },
                  child: Container(
                    child: const CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage('assets/images/rename.jpg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Text(
                '                   Book a Test',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 90,
              ),
              Text(
                'Book Doctor',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 40,
              width: 370,
              decoration: BoxDecoration(
                  color: const Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Common Disease',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: allans.map<Container>((e) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(

                      children: [
                        CircleAvatar(
                          backgroundImage:  NetworkImage("${serves.url}../image/blog/${e['menu_image']}"),
                          radius: 40,
                          backgroundColor: Colors.blue[800],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          e['name'].toString(),
                          style: TextStyle(color: Colors.black),
                        ),

                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  // color: Color(0xFFeee9e9),
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    //color: Colors.teal,
                    child: Image.network("${serves.url}../image/banner/$buttomimag"),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Health Packages',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Our facility implements best practices and quality standards, making us one of the best renowned diagnostic labs.',
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
