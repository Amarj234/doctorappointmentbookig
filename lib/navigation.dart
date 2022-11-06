import 'package:flutter/material.dart';
import 'package:living/navigatescreen/chat_page.dart';
import 'package:living/navigatescreen/home_page.dart';
import 'package:living/navigatescreen/offer_page.dart';
import 'package:living/navigatescreen/search_page.dart';
import 'package:living/navigatescreen/wallet_page.dart';
import 'package:living/screen/profile.dart';

import 'bookdoctor/book_doctor.dart';
class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
    //  Fluttertoast.showToast(msg: exit_warning);

      if(_selectedIndex==0) {
        return Future.value(true);
      }else{
        setState(() {
        //  return Future.value(true);
          _selectedIndex = 0;

        });

      }

    }
    return Future.value(false);
  }



  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DoctorPage(),
    WalletPage(),
    Profile(),
   // OfferPage(),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),

        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.teal,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home,color: Colors.white),
                  label:'Home',
                  backgroundColor: Colors.blue[800]
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.search,color: Colors.white),
                  label: 'Search',
                  backgroundColor: Colors.blue[800]
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.history,color: Colors.white),
                  label: 'History',
                  backgroundColor: Colors.blue[800]
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.manage_accounts_rounded,color: Colors.white),
                label:'Profile',
                backgroundColor: Colors.blue[800],
              ),
              // BottomNavigationBarItem(
              //   icon: const Icon(Icons.local_offer_outlined,color: Colors.white),
              //   label: 'Offer',
              //   backgroundColor: Colors.blue[800],
              // ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            iconSize: 25,
            onTap: _onItemTapped,
            // fixedColor: Colors.lightGreen,
            elevation:5,
            unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}
