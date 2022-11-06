import 'package:flutter/material.dart';
import 'package:living/screen/reset_password.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({Key? key}) : super(key: key);

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
final mobile=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top:50, left:10),
              child: const Icon(
                Icons.help_outline_outlined,
                color: Colors.teal,
                size: 100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10,top:20),
              child: Text(
                'Its okay! Reset Your Password',
                style: TextStyle(
                    color: Color(0xFF42afc6),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            const SizedBox(height: 30,),
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
                          borderSide: const BorderSide(width: 1, color:Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color:Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color:Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: ('Enter Mobile number'),
                        hintStyle: TextStyle(fontSize: 13)
                    ),
                  ),
                )),
            const SizedBox(
              height: 30,
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
                      MaterialPageRoute(builder: (_) =>  ResetPage(mobile1:mobile.text)));
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),


          ],
        ),
      ),


    );
  }
}
