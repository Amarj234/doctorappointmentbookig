import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/login_page.dart';
class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Setting',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: const Text(
                      'GENERAL',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text(
                    'Abut',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text(
                    'Privacy & Policy',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text(
                    'Help & Support',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text(
                    'Share with friends',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text(
                    'rate',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () async{
                    SharedPreferences prefs =await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.push(
                      context,MaterialPageRoute(builder: (context)=> LoginPage()),
                    );

                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
