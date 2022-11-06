import 'package:flutter/material.dart';
import 'package:living/confirmpage/confirm_page.dart';


class MyDoctor extends StatelessWidget {
  const MyDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          title: const Text(
            'My Doctor',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xFF42afc6),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              AssetImage('assets/images/physician.jpg'),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dr. Neha Singh',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'General Physician',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              '20 Years experience',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Delhi-PGI',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Fee:200 Rs',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Booking Date-04/07/2022',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>  CnfPage(did:"26",dname:"amar",payment:'630',type:'')));
                              },

                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    'Booked',
                                    style: TextStyle(
                                        color: Color(0xFF42afc6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xFF42afc6),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              AssetImage('assets/images/physician.jpg'),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dr. Neha Singh',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'General Physician',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              '20 Years experience',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Delhi-PGI',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Fee:200 Rs',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Booking Date-04/07/2022',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>  CnfPage(did:"26",dname:"Amarjeet",payment:'630',type:'') ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    'Booked',
                                    style: TextStyle(
                                        color: Color(0xFF42afc6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xFF42afc6),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              AssetImage('assets/images/physician.jpg'),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Dr. Neha Singh',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'General Physician',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              '20 Years experience',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Delhi-PGI',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Fee:200 Rs',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Booking Date-04/07/2022',
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>  CnfPage(did:"26",dname:"Amarjeet",payment:'630',type:'') ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    'Booked',
                                    style: TextStyle(
                                        color: Color(0xFF42afc6),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
