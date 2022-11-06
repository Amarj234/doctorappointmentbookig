import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:living/navigation.dart';
import 'package:living/screen/forget_password.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:living/screen/otp_page.dart';
import 'package:living/screen/sign_page.dart';

import '../servise.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Serves serves=Serves();

  final email=  TextEditingController();

  final password=  TextEditingController();

  logIn() async{


    var url2 = Uri.parse(serves.url+"login.php");
    print(url2);
    var response = await http.post(url2, body: {

      'email':email.text,
      'password': password.text,


    });

    if (response.statusCode == 200) {

      var data =jsonDecode(response.body);
      print(data);
      if(data['check']==1){

        EasyLoading.showSuccess('Login Success!');
        setsesiion(data['check'].toString(),data['user'].toString(),data['regid'].toString(),  );
        Navigator.push(
          context,MaterialPageRoute(builder: (context)=> NavigationPage()),
        );
      }else{
        EasyLoading.showToast('Email Or Password Wrrong');
      }
      // Navigator.push(
      //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
      // );
    }
  }

  setsesiion(String check,String name,String regid,)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString('check', '1');
    prefs.setString('user', name);
    prefs.setString('regid', regid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [

            Container(
              height: 200,
              padding: const EdgeInsets.all(5),
              child: Image.asset('assets/images/vari.jpg'),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: email,
                    style: const TextStyle(
                      // height: 0.4,
                    ),
                    enabled: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,  color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,  color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1,  color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: ('Enter Mobile number/ Email id'),
                      hintStyle: TextStyle(fontSize: 13)
                    ),
                  ),
                )),

            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: password,
                    style: const TextStyle(
                      // height: 0.4,
                    ),
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
                      hintText: ('Enter Password'),
                        hintStyle: TextStyle(fontSize: 13)
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  logIn();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  OtpVerification(mobile1:email.text)));
                  },
                child: const Text(
                  'Login with OTP',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ForgetPage()));
                },
                child: const Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                )),
            const SizedBox(
              height: 10,
            ),


            const SizedBox(
              height:10,
            ),
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignPage()));
                },
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
