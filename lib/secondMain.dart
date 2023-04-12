import 'package:flutter/material.dart';
import 'package:selfstudy/Page/EngUI.dart';
import 'Page/HomeUI.dart';
import 'Page/ShopUI.dart';
import 'Page/DialogUI.dart';
import 'Page/FirestoreUI.dart';
import 'Page/ygstargram.dart';
import 'Page/ListUI.dart';
import 'package:intl/intl.dart';
import 'Page/EngUI.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


class secondMain extends StatefulWidget {
  const secondMain({Key? key}) : super(key: key);

  @override
  State<secondMain> createState() => _secondMainState();
}

class _secondMainState extends State<secondMain> {
  var _selectedIndex =0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: [HomeUI(), EngUI(), Ygstargram()][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:'' ),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_sharp), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.send), label:''),
        ],
      ),
    );

  }
}

