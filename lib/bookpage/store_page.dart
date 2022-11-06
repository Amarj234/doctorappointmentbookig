import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../servise.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {


  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    getanswer();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

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
      'amount': 100*total,
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
    savedata(response.paymentId,response.orderId);

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
    savedata(response.walletName,"");
  }




  savedata(paymentId,orderId) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"cartshow.php");

    allans.forEach((element) async{
      print(element['pos_ad']);
      var response = await http.post(uri,body: {
        'proid':element['adv_id'].toString(),
        'usid':prefs.getString('regid').toString(),
        'mid':element['user_id'].toString(),
'update':"",
        'price':element['pos_ad'].toString(),
        'orderId':orderId.toString(),
        'paymentId':paymentId.toString(),
      });
      await getanswer();
    });
  }

  delete1(id)async{
    final uri = Uri.parse(serves.url+"cartdelete.php");
    var response = await http.post(uri,body: {
      'deid':id.toString(),

    });
    if(response.statusCode==200){
      getanswer();
    }
  }



bool isshow=true;


  Serves serves=Serves();
  List<dynamic> allans=[];


  getanswer() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"cartshow.php");
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

  int total=0;

  @override
  Widget build(BuildContext context) {
    total=0;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF4385f5),
          automaticallyImplyLeading: true,
          title: const Text(
            'Pathology Center',
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
      body:isshow?Center(child: CircularProgressIndicator(),) : SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [

Column(
  children: allans.map((row) {
     total=total+int.parse(row['pos_ad']);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color(0xFFeee9e9),

                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    //color: Colors.teal,
                    child: Image.network("${serves.url}../image/test/${row['img']}"),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Row(
                          children: [
                            Text(
                              row['Adv'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),

                            IconButton(onPressed: (){
delete1(row['id']);
                            }, icon: Icon(Icons.delete,color: Colors.red,))
                          ],
                        ),
                        // Text(
                        //   "Member-${row['membername']}",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 16),
                        // ),
                        Text(
                          row['text1'].toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          row['text1'].toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          '10:00 Am - 5:30',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Text(
                          "Price- ${row['pos_ad']}",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }).toList(),
),

            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:allans.length==0 ?Center(child: Container( child: Text('Data Not Found'),)) : Container(
                //padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: const Color(0xFF689df7),
                    borderRadius: BorderRadius.circular(20)),
                child:  TextButton(
                  onPressed: () {
                    openCheckout();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const StorePage()));
                  },
                  child:  Text(
                    '₹ $total Pay',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
