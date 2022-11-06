import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:living/screen/login_page.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../servise.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key, required this.mobile1}) : super(key: key);
  final mobile1;

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
bool isshow =false;



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
final password=TextEditingController();
final cpassword=TextEditingController();

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
setState(() {
  isshow =true;
});


    }else{

    }
    // Navigator.push(
    //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
    // );
  }
}

checknew() async{
if(password.text==cpassword.text) {
  var url2 = Uri.parse(serves.url + "login.php");
  var response = await http.post(url2, body: {
    'pupdate': widget.mobile1,

    'password': password.text,
    'cpassword': cpassword.text,
  });
  print(response.body + "hgfj");
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);

    if (data == 1) {
      EasyLoading.showSuccess('Password update Success!');
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const LoginPage()));
    }
    // Navigator.push(
    //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
    // );
  }
}else{
  EasyLoading.showSuccess('Password not match!');

}
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
          child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 10),
                  child: const Icon(
                    Icons.lock_rounded,
                    color: Colors.teal,
                    size: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: const Text(
                    ' Reset Your Password',
                    style: TextStyle(
                        color: Color(0xFF42afc6),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),

                Visibility(
visible: isshow ? false :true,
                    child: Column(children: [
                  Container(
                    child:  Padding(
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
                  ),

                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Color(0xFF344543),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () {
                            checkOtp(codes.text);
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (_) => const LoginPage()));
                           },
                          child: const Text(
                            'Verify',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),

                ],)),





                const SizedBox(
                  height: 10,
                ),
             Visibility(
                 visible: isshow,
                 child: Column(
               children: [
                 Container(
                     padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                     child: SizedBox(
                       height: 40,
                       child: TextField(
                         controller: password,
                         //style: const TextStyle(height: 0.4),
                         decoration: InputDecoration(
                             filled: true,
                             fillColor: Colors.white,
                             focusedBorder: OutlineInputBorder(
                                 borderSide:
                                 const BorderSide(width: 1, color: Colors.grey),
                                 borderRadius: BorderRadius.circular(20)),
                             enabledBorder: OutlineInputBorder(
                                 borderSide:
                                 const BorderSide(width: 1, color: Colors.grey),
                                 borderRadius: BorderRadius.circular(20)),
                             border: OutlineInputBorder(
                                 borderSide:
                                 const BorderSide(width: 1, color: Colors.grey),
                                 borderRadius: BorderRadius.circular(20)),
                             hintText: ('Enter Password'),
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
                         controller: cpassword,
                         //  style: const TextStyle(height: 0.4),
                         decoration: InputDecoration(
                             focusedBorder: OutlineInputBorder(
                                 borderSide:
                                 const BorderSide(width: 1, color: Colors.grey),
                                 borderRadius: BorderRadius.circular(20)),
                             enabledBorder: OutlineInputBorder(
                                 borderSide:
                                 const BorderSide(width: 1, color: Colors.grey),
                                 borderRadius: BorderRadius.circular(20)),
                             border: OutlineInputBorder(
                                 borderSide:
                                 const BorderSide(width: 1, color: Colors.grey),
                                 borderRadius: BorderRadius.circular(20)),
                             hintText: ('Enter confirm Password'),
                             hintStyle: TextStyle(fontSize: 13)
                         ),
                       ),
                     )),

                 const SizedBox(
                   height: 40,
                 ),
                 Container(
                   height: 40,
                   width: 300,
                   decoration: BoxDecoration(
                       color: Color(0xFF344543),
                       borderRadius: BorderRadius.circular(20)),
                   child: TextButton(
                     onPressed: () {
                       checknew();

                     },
                     child: const Text(
                       'Reset Password',
                       style: TextStyle(fontSize: 14, color: Colors.white),
                     ),
                   ),
                 ),

               ],
             )),

              ]
          ),
        ),
      ),
    );
  }
}
