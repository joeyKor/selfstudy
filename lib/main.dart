import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfstudy/Page/LoginScreen.dart';
import 'package:selfstudy/secondMain.dart';
import 'Page/HomeUI.dart';
import 'Page/ShopUI.dart';
import 'Page/DialogUI.dart';
import 'Page/FirestoreUI.dart';
import 'Page/ygstargram.dart';
import 'Page/ListUI.dart';
import 'Store/sotre1.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);

  runApp(ChangeNotifierProvider(
    create: (c)=> Store1(),
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
