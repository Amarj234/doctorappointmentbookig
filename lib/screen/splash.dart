import 'dart:async';
import 'package:flutter/material.dart';
import 'package:living/screen/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => checksesiion());
  }
  checksesiion() async{

    SharedPreferences prefs =await SharedPreferences.getInstance();

    if(prefs.getString('check')=='1'){

      Navigator.push(
        context,MaterialPageRoute(builder: (context)=> NavigationPage()),
      );

    }else{
      Navigator.push(
        context,MaterialPageRoute(builder: (context)=> LoginPage()),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF344543),
      body:  Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image:
            DecorationImage(image: AssetImage('assets/images/root.jpg'),
              // fit: BoxFit.fill




            ))
        ,
      ),


    );
  }
}
