import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Help Center',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 10),
              color: const Color(0xFFeee9e9),
              height: 40,
              width: 400,
              child: const Text(
                'I have an issue with',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Booking a new Appointment',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 143, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Existing Appointment',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 180, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Online Consultation',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 186, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Feedback',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 240, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Diagnostic Tests',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 200, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Health Plans',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 220, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'My Account',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 225, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Have a feature in mind',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 165, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: const Text(
                    'Other Issues',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 215, top: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
