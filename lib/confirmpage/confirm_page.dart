import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../navigation.dart';
import '../servise.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CnfPage extends StatefulWidget {
   CnfPage({Key? key, required this.dname, required this.did, required this.payment, required this.type}) : super(key: key);
final dname,did,payment,type;
  @override
  State<CnfPage> createState() => _CnfPageState();
}

class _CnfPageState extends State<CnfPage> {

  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
    getdate();
    print(cureent);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

DateTime cureent =DateTime.now();
    Serves serves=Serves();
    List allans=[];
  DateTime fristime1=DateTime.now();
  DateTime endtime1=DateTime.now();

  getdate() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    fistname.text=prefs.getString('user').toString();
    allans=[];
      final uri = Uri.parse(serves.url+"showtime.php");
      var response = await http.post(uri,body: {
        'drid':widget.did,

      });

      var state= json.decode(response.body);

      fisttime=state[0]['startingtime'];
      secendtime=state[0]['endtime'];


      int cou=  cureent.day+30;

      var startingtime;
      var endtime;
      var bookinglimit;
      var totalminust;
      for(int i=0;i<30;i++) {
        DateTime allt = cureent.add(Duration(days: i));

        state.forEach((row) async {
          print(DateFormat.EEEE().format(allt)+row['weekday']+i.toString());
          if(row['weekday']==DateFormat.EEEE().format(allt)){
          //  print(row['weekday']+DateFormat.EEEE().format(allt));

            startingtime   =row['startingtime'];
            endtime      =row['endtime'];
            bookinglimit  =row['bookinglimit'];
            totalminust  =row['totalminust'];
            var productMap = {
              'startingtime': startingtime,
              'endtime': endtime,
              'bookinglimit': bookinglimit,
              'totalminust':totalminust,
              'weekday': DateFormat.MMMEd().format(allt),

            };
           // checkstatus(DateFormat.MMMEd().format(allt),bookinglimit);

       //  print(checkstatus(DateFormat.MMMEd().format(allt),bookinglimit));
            setState(() {
              allans.add(productMap);
              isselect=state[0]['weekday'];
            });
          }
        });

      }

      gettime(state[0]['startingtime'],state[0]['endtime'],state[0]['bookinglimit'],state[0]['totalminust'],state[0]['weekday']);
//print(allans);
    }


  List stat=[];


  List<dynamic> alltimearr1=[];


  gettime(stime,etime,inter,tminuts,date) async {
    setState(() {
      alltimearr1=[];
      stat=[];
    });

    print("gettime");
    double lo= int.parse(tminuts)/int.parse(inter);
    fristime1 = new DateFormat.jm().parse(stime);
      endtime1  = new DateFormat.jm().parse(etime);
int mylim=int.parse(inter);

  for(int i=0;i<(lo.toInt()-1);i++){
    var amr=fristime1.add(Duration(minutes: mylim));
    var gol=fristime1.add(Duration(minutes: mylim+int.parse(inter)));
    String mysate=DateFormat.jm().format(amr);

    final uri = Uri.parse(serves.url+"timestatus.php?drid=${widget.did}&week=$date&time=$mysate");
     print(uri);
    var response =await  http.get(uri);

    var check = response.body;

print(check);

    var productMap1 = {
      'fisttime': mysate.toString(),
      'secendtime':DateFormat.jm().format(gol).toString(),
      'check': check,
    };

    alltimearr1.add(productMap1);
        stat.add(check);
    mylim=mylim+int.parse(inter);
  }
  setState(() {
    isshow=false;
  });

  }

String? fisttime;
String? secendtime;
List attr=[];


Future<String>  checkstatus(row,count)async{

    final uri = Uri.parse(serves.url+"showtime.php?drid=${widget.did}&week=$row&count=$count");
    var response =await  http.get(uri);

    var check =response.body;

attr.add(check);

return check;
  }



  late Razorpay _razorpay;


  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {


    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"getuser.php");
    var response = await http.post(uri,body: {
      'showdata':prefs.getString('regid'),

    });

    var state= json.decode(response.body);

    print('payment');

    var options = {
      'key': 'rzp_live_Hm1SizgLEYnxak',
      'amount': 100*int.parse(widget.payment),
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': state[0]['ctel'].toString(), 'email': state[0]['cemail'].toString()},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
    print(response.paymentId);
    Booknow(response.paymentId,response.orderId);

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
    Booknow(response.walletName,"");
  }







  Booknow(paymentId,orderId)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    //print('8382946376');
    var url2 = Uri.parse(serves.url + "book.php");
    var response = await http.post(url2, body: {
      'name': fistname.text,
      'mobile': mobile.text,
      'age': email.text,
      'Disease': relation.text,
      'drid': widget.did,
      'regid': prefs.get('regid').toString(),
      'payment':widget.payment,
      'date': isselect,
      'time': isselect2,
      'type': widget.type,
      "transID":paymentId.toString(),

    });

    if (response.statusCode == 200) {
      var check = jsonDecode(response.body);
      _showMyDialog();
      print(check);

      // Navigator.push(
      //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
      // );
    }

  }






  bool isshowdlo=false;

bool isshow=true;
  String? isselect;
  String? isselect2;
  @override
  Widget build(BuildContext context) {
   int m=-1;
    return Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.teal,
          title:  Text(
            'Book an Appointment',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: isshow ? Center(child: CircularProgressIndicator()): allans.length==0 ? Center(child:Text('Data not Found')) :SafeArea(
          child: Column(
            children: [
              Container(
                padding:  EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children:  [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                      AssetImage('assets/images/physician.jpg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.dname.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      '(General Surgeon)',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
               Text(
                'Choose A Date',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              // const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: allans.map<Padding>((row) {
                      m++;
                      return   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            if(isselect!=row['weekday']) {
                              // checkstatus(
                              //     row['weekday'], row['bookinglimit']);


                              isselect = row['weekday'];


                              gettime(row['startingtime'], row['endtime'],
                                  row['bookinglimit'], row['totalminust'],
                                  row['weekday']);
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: row['weekday']==isselect ? Colors.yellow : Color(0xFFeee9e9),
                             ),
                             // height: 45,
                              width: 130,

                              child: Center(
                                child: Column(
                                  children: [
                                    Text(row['weekday'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                                  //  Text(attr[m].toString(),style: TextStyle(fontSize: 12,color: Colors.green),)
                                  ],
                                ),
                              ),
                          ),
                        ),
                      );

                    }).toList(),
                  ),
                ),
              ),


              const Text(
                'Choose A Time',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200,
                child: alltimearr1.length==0 ?Center(child: CircularProgressIndicator()):  GridView.count(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: 4,
                  children: alltimearr1.map((row){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){

                          setState(() {
                             if(row['check']=='0') {
                            //
                            isselect2 = row['fisttime'].toString();
                             }
                            print(isselect2);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:   row['fisttime']==isselect2 ? Colors.green :row['check']=='0' ? Color(0xFFeee9e9):  Colors.redAccent,
                            ),
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            height: 45,

                            child: Column(children: [
                              Text(row['fisttime'],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10),),
                              Text("to"),
                              Text(row['secendtime'],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10),),
                            ],)
                        ),
                      ),
                    );

                  }).toList(),
                ),
              ),
              const SizedBox(height: 20,),
              Visibility(
                visible: isshowdlo ? false :true,
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xFF344543),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      setState((){
                        isshowdlo=true;
                      });
                      _displayDialog(context);
                    },
                    child: const Text(
                      'Add Details',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible:isshowdlo ,
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xFF344543),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {

                      openCheckout();
                    },
                    child:  Text(
                      'PAY ${widget.payment} Rs',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ));
  }


  final _formKey = GlobalKey<FormState>();
  String? errtext;

  final fistname=  TextEditingController();
  final mobile=    TextEditingController();
  final email=     TextEditingController();
  final relation=  TextEditingController();






  _displayDialog(BuildContext context){
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return StatefulBuilder(builder: (context, StateSetter setState)
          {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,


                    decoration: BoxDecoration(
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 100,),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  'Patient details',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),

                              Container(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: mobile,
                                      keyboardType: TextInputType.number,
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
                                              const BorderSide(width: 1, color: Color(0xFFB2DFDB)),
                                              borderRadius: BorderRadius.circular(20)),
                                          border: OutlineInputBorder(
                                              borderSide:
                                              const BorderSide(width: 1, color: Color(0xFFB2DFDB)),
                                              borderRadius: BorderRadius.circular(20)),
                                          hintText: ('Mobile number'),
                                          hintStyle: TextStyle(fontSize: 13)
                                      ),
                                    ),
                                  )),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: fistname,
                                      // style: const TextStyle(height: 0.4),
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
                                          hintText: ('Full Name'),
                                          hintStyle: TextStyle(fontSize: 13)
                                      ),
                                    ),
                                  )),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: email,
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
                                          hintText: ('Age'),
                                          hintStyle: TextStyle(fontSize: 13)
                                      ),
                                    ),
                                  )),
                              Container(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                     // maxLines: 2,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: relation,
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
                                          hintText: ('Disease'),
                                          hintStyle: TextStyle(fontSize: 13)
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 20,),

                            ],
                          ),
                        ),




                        ElevatedButton(
                           onPressed: ()async{
                             if (_formKey.currentState!.validate()) {
                               // If the form is valid, display a snackbar. In the real world,
                               // you'd often call a server or save the information in a database.

                         Navigator.pop(context);
                         Timer(Duration(seconds: 2), (){
                           setState((){
                             isshowdlo=true;
                           });
                         });

                             }

                           }
                            ,
                            child: Text('ok'),
                          ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }



  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Successfully'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(' Schedule Date $isselect'),
                Text(' Schedule Time $isselect'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.push(
                  context,MaterialPageRoute(builder: (context)=> NavigationPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }


}
