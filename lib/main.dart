import 'package:flutter/material.dart';
import 'package:living/screen/splash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  Splash(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}


