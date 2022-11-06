import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:living/screen/login_page.dart';

import '../servise.dart';



class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController dateinput = TextEditingController();

  //text editing controller for text field



  final _formKey = GlobalKey<FormState>();
  String? errtext;
  Serves serves=Serves();

  final fistname=  TextEditingController();
  final mobile=  TextEditingController();
  final gender=  TextEditingController();
  final password=  TextEditingController();
  final cpassword=  TextEditingController();

  Future singUp() async{

    print('8382946376');
    if(password.text==cpassword.text) {
      var url2 = Uri.parse(serves.url + "register.php");
      var response = await http.post(url2, body: {
        'fname': fistname.text,
        'mobile': mobile.text,
        'gender': gender.text,
        'password': password.text,
        'cpassword': cpassword.text,

      });
      print(response.body);
      if (response.statusCode == 200) {
        var check = jsonDecode(response.body);

        if (check == 1) {
          EasyLoading.showSuccess('Registration Success!');
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          EasyLoading.showToast('Email already Register');

          // EasyLoading.dismiss();
        }
        // Navigator.push(
        //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
        // );
      }
    }else{
      setState(() {
        EasyLoading.showToast('Password not match');
        errtext="Password not match";
      });
    }
  }

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Image.asset(
                          'assets/images/pana.png',
                          height: 200,
                          width: 200,
                        )),
                    Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: fistname,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            //style: const TextStyle(height: 0.4),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(width: 1,color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(width: 1,color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: ('Name'),
                                hintStyle: TextStyle(fontSize: 13)
                            ),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: mobile,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
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
                              hintText: ('Mobile Number'),
                                hintStyle: TextStyle(fontSize: 13)
                            ),
                          ),
                        )
                    ),

                    Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: gender,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            //  style: const TextStyle(height: 0.4),
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
                              hintText: ('Gender'),
                                hintStyle: TextStyle(fontSize: 13)
                            ),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            // style: const TextStyle(height: 0.4),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(width: 1,color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                border: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: ('Password'),
                                hintStyle: TextStyle(fontSize: 13)
                            ),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: cpassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            // style: const TextStyle(height: 0.4),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(width: 1,color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                border: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: ('Confirm Password'),
                                hintStyle: TextStyle(fontSize: 13)
                            ),
                          ),
                        )),

                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Color(0xFF344543),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            singUp();
                          }      },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ))));
  }
}
