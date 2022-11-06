import 'package:flutter/material.dart';
import 'package:living/bookdoctor/book_doctor.dart';
class Consultation extends StatelessWidget {
  const Consultation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Online Consultation',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset('assets/images/consult.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: const Text(
                  'Start your care now by choosing from over 2000 doctors and 58 specialities',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 30,
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
                        MaterialPageRoute(builder: (_) => const DoctorPage()));
                  },
                  child: const Text(
                    'Consult Now',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
