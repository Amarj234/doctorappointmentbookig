import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../servise.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getanswer();
  }
  bool isshow=true;


  Serves serves=Serves();
  List<dynamic> allans=[];
  getanswer() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"historyshow.php");
    var response = await http.post(uri,body: {
      'showdata':prefs.getString('regid'),


    });

    var state= json.decode(response.body);
    print(state);
    allans=[];
    setState(() {
      allans=state;
      isshow=false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal,
        title: const Text(
          'Wallet',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:isshow? Center(child: CircularProgressIndicator()): SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top:40),
              alignment: Alignment.topCenter,
              child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage('assets/images/cur.png'),

              ),

            ),
            // Container(
            //       padding: const EdgeInsets.only(top: 10),
            //
            //       child: const Text('15160.00', style: TextStyle(
            //           color: Colors.black, fontWeight: FontWeight.bold),)),
            //
            // Container(
            //   padding: const EdgeInsets.only(
            //     top: 10,
            //   ),
            //   child: const Text(
            //     'Balance',
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),


            const SizedBox(height: 20,),
            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  color: const Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                //  showDialog(context: context, builder: (ctx) =>
                      // AlertDialog(
                      //   title:  Container(
                      //       padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      //       child: SizedBox(
                      //         height: 40,
                      //         child: TextField(
                      //           keyboardType: TextInputType.number,
                      //           enabled: true,
                      //           decoration: InputDecoration(
                      //               fillColor: Colors.white,
                      //               focusedBorder: OutlineInputBorder(
                      //                   borderSide: const BorderSide(
                      //                       width: 1,  color:  Color(0xFF344543)),
                      //                   borderRadius: BorderRadius.circular(20)),
                      //               enabledBorder: OutlineInputBorder(
                      //                   borderSide: const BorderSide(
                      //                       width: 1,  color:  Color(0xFF344543)),
                      //                   borderRadius: BorderRadius.circular(20)),
                      //               border: OutlineInputBorder(
                      //                   borderSide: const BorderSide(
                      //                       width: 1,  color:  Color(0xFF344543)),
                      //                   borderRadius: BorderRadius.circular(20)),
                      //               hintText: ('Enter Amount'),
                      //               hintStyle:const TextStyle(fontSize: 13)),
                      //         ),
                      //       )),
                      //   actions: <Widget>[
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.of(ctx).pop();
                      //       },
                      //       child: Container(
                      //         height: 40,
                      //         width: 100,
                      //         decoration: BoxDecoration(
                      //             color: const Color(0xFF344543),
                      //             borderRadius: BorderRadius.circular(20)),
                      //         child: TextButton(
                      //           onPressed: () {
                      //             // Navigator.push(
                      //             //     context,
                      //             //     MaterialPageRoute(
                      //             //         builder: (_) => const ChooseDay()));
                      //           },
                      //           child: const Text(
                      //             'Submit',
                      //             style:
                      //             TextStyle(fontSize: 14, color: Colors.white),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      //
                      //
                      // ));
                },
                child: const Text(
                  'Payment History',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text('History',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
            const SizedBox(height:5,),
       Column(children: allans.map((row) {
         return Column(
           children: [
             IntrinsicHeight(
               child: Padding(
                 padding: const EdgeInsets.only(top: 10.0),
                 child: Row(

                   children: [
                     Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 10.0),
                               child: Container(
                                 child: const Text(
                                   'Amount',
                                   style: TextStyle(color: Colors.black),
                                 ),
                               ),
                             ),



                             Padding(
                               padding: const EdgeInsets.only(left: 10.0),
                               child: Container(
                                 child: const Text(
                                   'Date',
                                   style: TextStyle(color: Colors.black),
                                 ),
                               ),
                             ),

                             Padding(
                               padding: const EdgeInsets.only(left: 10.0),
                               child: Container(
                                 child: const Text(
                                   'Transaction Id',
                                   style: TextStyle(color: Colors.black),
                                 ),
                               ),
                             ),
                           ],
                         )),
                     const VerticalDivider(
                       color: Colors.black,
                       thickness: 1,
                       indent: 0,
                       endIndent: 0,
                     ),
                     Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 10.0),
                               child: Container(
                                 child:  Text(
                                   row['price'].toString(),
                                   style: TextStyle(color: Colors.black),
                                 ),
                               ),
                             ),

                             Padding(
                               padding: const EdgeInsets.only(left: 10.0),
                               child: Container(
                                 child:  Text(
                                   row['orderTime'].toString(),
                                   style: TextStyle(color: Colors.black),
                                 ),
                               ),
                             ),

                             Padding(
                               padding: const EdgeInsets.only(left: 10.0),
                               child: Container(
                                 child:  Text(
                                   row['transID'].toString(),
                                   style: TextStyle(color: Colors.black),
                                 ),
                               ),
                             ),
                           ],
                         )),
                   ],
                 ),
               ),
             ),
             const SizedBox(height:25,),

           ],
         );

       }).toList()


         ,)

          ],
        ),
      )),
    );
  }
}
