import 'package:flutter/material.dart';
import 'Page/HomeUI.dart';
import 'Page/ShopUI.dart';
import 'Page/DialogUI.dart';
import 'Page/FirestoreUI.dart';
import 'Page/ygstargram.dart';
import 'Page/ListUI.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  var _selectedIndex =0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          showDialog(context: context, builder: (builder){
            return DialogUI();
          });

        },
        child: Icon(Icons.add_box),
      ),
      appBar: AppBar(
        title: Text('KimJuYeong 스타그램'),
      ),
      body: [HomeUI(),ListUI(),Ygstargram()][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:'home' ),
          BottomNavigationBarItem(icon: Icon(Icons.add_chart), label: 'shop'),
          BottomNavigationBarItem(icon: Icon(Icons.data_array), label:'firestore'),
        ],
      ),
    );

  }
}
