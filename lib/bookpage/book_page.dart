import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:living/family/family_page.dart';
import 'package:http/http.dart' as http;
import '../servise.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'store_page.dart';


class BookPage extends StatefulWidget {
  const BookPage({Key? key, required this.usid, required this.mid}) : super(key: key);
  final usid;
  final mid;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {



  void initState() {
    // TODO: implement initState
    super.initState();
    getanswer();
  }

  Serves serves=Serves();
  List<dynamic> allans=[];

  getanswer() async{
print(search.text);
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final uri = Uri.parse(serves.url+"showtest.php");
    var response = await http.post(uri,body: {
      'showdata':prefs.getString('regid').toString(),
      'search':search.text.toString(),
    });

var state= json.decode(response.body);
    print(state);
    allans=[];
    setState(() {
      allans=state;
      isshow=false;
    });
//print("${serves.url}../image/test/${state[0]['img']}");
  }

  addtocart(proid) async{

print('addtocart $proid');
    final uri = Uri.parse(serves.url+"cartshow.php");
    var response = await http.post(uri,body: {
      'proid':proid.toString(),
      'usid':widget.usid.toString(),
      'mid':widget.mid.toString(),
"insert":"",

    });
    if (response.statusCode == 200) {
      var check = jsonDecode(response.body);
      print(" $check");
      if (check == 1) {

        EasyLoading.showSuccess('Service add Success!');
        getanswer();
      }
      // Navigator.push(
      //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
      // );
    }

  }

bool isshow=true;


final search =TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Book A Test',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () { Navigator.pop(context);
            },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        actions:  [
          InkWell(
            onTap: (){

              Navigator.push(
                context,MaterialPageRoute(builder: (context)=> StorePage()),
              );
            },
            child: Icon(
              Icons.shopping_cart_checkout_sharp,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      body: isshow ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    onChanged: (v){
                      getanswer();
                      setState(() {

                      });
                    },
                    controller: search,
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
                        hintText: ('Search with test name or code'),
                        suffixIcon: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                        prefixIcon: const Icon(
                          Icons.filter_alt,
                          size: 30,
                        )),
                  ),
                ),
              ),
              const SizedBox(height:10,),
              const   Divider(
                thickness:1,
                indent: 0,
                endIndent: 0,
                color: Colors.grey,
                height:10,
              ),
              const SizedBox(
                height: 20,
              ),

            Container(
              child: allans.length==0? Center(child: Text("Data not Found"),)  :  Column(
                children: allans.map<Container>((e) {
                  return   Container(
                    child: Column(
                      children: [

                       Container(child: e['img']==""? Image.asset("assets/images/fever.jpg")  :  Image.network("${serves.url}../image/test/${e['img']}")),


                        Container(
                            padding: const EdgeInsets.only(left: 40,top: 10),
                            child: Row(
                              children: [
                                Icon(Icons.bloodtype,color: Colors.red,size: 30,),
                                Text(
                                  e['Adv'].toString(),
                                  style: TextStyle(
                                      color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                              ],
                            )


                        ),


                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children:  [
                              Icon(
                                Icons.report_gmailerrorred,
                                color: Colors.black,
                              ),
                              Text(
                                e['text1'].toString(),
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children:  [
                              Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              Text(
                                e['text2'].toString(),
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children:  [
                              Icon(
                                Icons.notes,
                                color: Colors.black,
                              ),
                              Text(
                                e['text3'].toString(),
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: e['cart']==null ? Color(0xFF344543) :Color(
                                  0xFFCFE1DF),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                            onPressed: () {
                              addtocart(e['adv_id']);

                            },
                            child: e['cart']==null ?  Text(
                              'ADD TO CART',
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ) : Text(
                              'Added',
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height:10,),
                        const   Divider(
                          thickness:1,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.grey,
                          height:10,
                        ),
                      ],
                    ),
                  );

                }).toList(),
              ),
            )






            ],
          )),
    );
  }
}
