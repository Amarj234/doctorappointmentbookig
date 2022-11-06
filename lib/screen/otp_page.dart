import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:living/navigatescreen/home_page.dart';

import '../servise.dart';


class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key, required this.mobile1}) : super(key: key);
  final mobile1;
  @override
  State<OtpVerification > createState() => _OtpVerification ();
}
class _OtpVerification  extends State<OtpVerification > {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listenotp();
  }
  _listenotp() async{
    await SmsAutoFill().listenForCode;
    await sendotpf();
  }

  Serves serves=Serves();
String? _code;
final codes=TextEditingController();

  Future checkOtp(String code) async{

    print('8382946376  $code');
    var url2 = Uri.parse(serves.url+"checkotp.php");
    var response = await http.post(url2, body: {
      'mobile': widget.mobile1,
      'otp':code,
    });
    print(response.body);
    if (response.statusCode == 200) {

      var check =jsonDecode(response.body);

      if(check==1){

        checknew();

      }else{

      }
      // Navigator.push(
      //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
      // );
    }
  }

  checknew() async{

    var url2 = Uri.parse(serves.url+"login.php");
    var response = await http.post(url2, body: {
      'mobile': widget.mobile1,
    });
    print(response.body+"hgfj");
    if (response.statusCode == 200) {

      var data =jsonDecode(response.body);
      print(data);

      if(data['check']==1){
        setsesiion(data['check'].toString(),data['user'].toString(),data['regid'].toString(),  );


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
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const HomePage ()));
  }


  Future sendotpf() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final  gencode= await SmsAutoFill().getAppSignature;
    if(widget.mobile1.length==10) {
      var url4 = Uri.parse(serves.url+"sendotp.php");
      var response = await http.post(url4, body: {
        'mobile': widget.mobile1,
        'gencode':gencode,
      });
      if (response.statusCode == 200) {
        prefs.setString('mobile', widget.mobile1);
        print('OTP Sent on Your Mobile');
        // Navigator.push(
        //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
        // );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 130,
              //padding: const EdgeInsets.all(1),
              child: Image.asset('assets/images/otp.jpg'),
            ),
            Container(
              alignment: Alignment.topCenter,
              // padding: const  EdgeInsets.only(top:5),
              child: const Text(
                'Welcome Back!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  color: Color(0xFF344543),),
              ),
            ),
            // const SizedBox(height:4,),
            Container(
              alignment: Alignment.topCenter,
              // padding: const  EdgeInsets.only(top:5),
              child: const Text(
                'Please login your account',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.topCenter,
              // padding: const  EdgeInsets.only(top:5),
              child: const Text(
                'OTP is sent to your Mobile Number',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5c6a68)),
              ),
            ),
            // const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(40),
              child:       PinFieldAutoFill(
                controller: codes,
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),

                onCodeSubmitted: (code) {
                  checkOtp(code);
                },
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    checkOtp(code);

                  }
                },
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: const Text(
                    'do not receive otp?',
                    style: TextStyle(color: Color(0xFF5c6a68), fontSize: 14),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Request again',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF344543),
                      ),
                    ))
              ],
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Give a Call',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF344543),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),

            Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                  color: Color(0xFF344543),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  checkOtp(codes.text);




                },
                child: const Text(
                  'Verify',
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
