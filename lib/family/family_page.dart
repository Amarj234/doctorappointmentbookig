import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:living/bookpage/book_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../servise.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({Key? key}) : super(key: key);

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {

  final _formKey = GlobalKey<FormState>();
  String? errtext;
  Serves serves=Serves();

  final fistname=  TextEditingController();

  final mobile=  TextEditingController();

  final email=  TextEditingController();

  final relation=  TextEditingController();



  Future singUp() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    //print('8382946376');
      var url2 = Uri.parse(serves.url + "addmember.php");
      var response = await http.post(url2, body: {
        'fname': fistname.text,
        'mobile': mobile.text,
        'email': email.text,
        'relation': relation.text,
        'usid': prefs.get('regid').toString(),

      });

      if (response.statusCode == 200) {
        var check = jsonDecode(response.body);
print(check);
        if (check == 0) {
          EasyLoading.showToast('Mobile already Register');
        } else {

          EasyLoading.showSuccess('Add Success!');
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookPage(usid:prefs.get('regid'),mid:check)),
          );          // EasyLoading.dismiss();
        }
        // Navigator.push(
        //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
        // );
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body:SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Add Family Member',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Enter your family details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: mobile,
                          //style: const TextStyle(height: 0.4),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 1, color: Color(0xFFB2DFDB)),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 1, color: Color(0xFFB2DFDB)),
                                borderRadius: BorderRadius.circular(20)),
                            hintText: ('Mobile number'),
                              hintStyle: TextStyle(fontSize: 13)
                          ),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: fistname,
                          // style: const TextStyle(height: 0.4),
                          decoration: InputDecoration(
                            filled: true,
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
                            hintText: ('Full Name'),
                              hintStyle: TextStyle(fontSize: 13)
                          ),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: email,
                          //style: const TextStyle(height: 0.4),
                          decoration: InputDecoration(
                            filled: true,
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
                            hintText: ('Email ID'),
                              hintStyle: TextStyle(fontSize: 13)
                          ),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: relation,
                          //style: const TextStyle(height: 0.4),
                          decoration: InputDecoration(
                            filled: true,
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
                            hintText: ('Relation'),
                              hintStyle: TextStyle(fontSize: 13)
                          ),
                        ),
                      )),
                  const SizedBox(height: 20,),
                  Container(
                    height: 40,
                    width: 300,
                    decoration: BoxDecoration(
                        color: const Color(0xFF344543),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.

                          singUp();
                        }

                        },
                      child: const Text(
                        'ADD PATIENT',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
