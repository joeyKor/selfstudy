import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfstudy/Store/sotre1.dart';
import 'package:selfstudy/secondMain.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:ui';
import 'package:selfstudy/Store/sotre1.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
final firestore = FirebaseFirestore.instance;
final db = FirebaseFirestore.instance;


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var collec = 'register';

  var approval =[];
  var hint = [];
  var pw =[];
  var school =[];
  var result = <String, dynamic>{};
  late ScrollController _scrollController;

  getData() async {

    var result = await firestore.collection('register').get();
    for (var doc in result.docs){
      context.read<Store1>().addUser(doc['ID'], doc['url']);
      print(doc['ID']);
      print(context.watch<Store1>().name);
    }
    
    // var result2 = await firestore.collection('collec').get();

    // Map<String, dynamic> jsonData = jsonDecode(result2);

    // for (var doc in result.docs) {
    //   approval.add(doc['approval']);
    //   hint.add(doc['hint']);
    //   pw.add(doc['pw']);
    //   school.add(doc['school']);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
//
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    // var size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width ;
    var inputId = TextEditingController();
    var inputPW = TextEditingController();



    // ID유효성 검사를 실시하였으나 실패
  // Future getDoc(name) async{
    //   var a = await FirebaseFirestore.instance.collection('register').doc(name).get();
    //   if(a.exists){
    //     print('Exists');
    //     return a;
    //   }
    //   if(!a.exists){
    //     AwesomeDialog(
    //       context: context,
    //       dialogType: DialogType.error,
    //       borderSide: const BorderSide(
    //         color: Colors.green,
    //         width: 2,
    //       ),
    //       width: 280,
    //       buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    //       dismissOnTouchOutside: true,
    //       dismissOnBackKeyPress: false,
    //       headerAnimationLoop: false,
    //       animType: AnimType.BOTTOMSLIDE,
    //       title: 'Inof',
    //       desc: "아이디를 확인해주세요.",
    //       showCloseIcon: true,
    //       btnOkOnPress: (){},
    //     ).show();
    //     return null;
    //   }
    //
    // }

    return ChangeNotifierProvider(
      create: (c)=> Store1(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffd6e2ea),
        body:
          SingleChildScrollView(
          controller: _scrollController,
          child: SizedBox(

            // width: size.width,
            // height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Text('여수여중stargram',style: TextStyle(fontFamily :'dodam', fontSize: 20, fontWeight: FontWeight.bold),),
                  //rive animation
                  SizedBox(
                    // width: size.width,
                    height: 200,
                    child: RiveAnimation.asset(
                      "assets/animated_login_character.riv",
                      stateMachines: const ["Login Machine"],
                      onInit: (artboard) {
                        controller = StateMachineController.fromArtboard(artboard, "Login Machine");
                        if (controller == null) return;

                        artboard.addController(controller!);
                        isChecking = controller?.findInput("isChecking");
                        isHandsUp = controller?.findInput("isHandsUp");
                        trigSuccess = controller?.findInput("trigSuccess");
                        trigFail = controller?.findInput("trigFail");
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  TextField(
                    controller: inputId,
                    onChanged: (value) {
                      if (isHandsUp != null) {
                        isHandsUp!.change(false);
                      }
                      if (isChecking == null) return;

                      isChecking!.change(true);
                    },

                    decoration: InputDecoration(
                      hintText: "Id",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onTap: ()async{

                      var result = await firestore.collection('register').get();
                      for (var doc in result.docs)  {

                        var storage = await SharedPreferences.getInstance();
                        storage.setString(doc['ID'], doc['url']);

                        // var result = storage.get('YangMinJi');
                        // print(result);
                        // context.read<Store1>().addUser(doc['ID'], doc['url']);
                        // print(doc['ID']);
                        // print(doc['url']);
                        // context.read<Store1>().addUser(doc['ID'], doc['url']);
                        // context.read<Store1>().addUser('b', 'eff');

                        // print("this is  watch {$context.watch<Store1>().users["KimJuYeong"]}');
                      }

                      _scrollController.animateTo(120.0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    controller: inputPW,
                    onChanged: (value) {
                      if (isChecking != null) {
                        isChecking!.change(false);
                      }
                      if (isHandsUp == null) return;

                      isHandsUp!.change(true);
                    },
                    obscureText: true, // to hide password
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    // width: size.width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                        },
                        child: Text(
                          // context.watch<Store1>().users["KimJuYeong"].toString(),
                          "Forgot your password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: double.infinity,
                    // minWidth: size.width,
                    height: 50,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    onPressed: () async{
                      // todo login


                      final docRef = db.collection("register").doc(inputId.text);




                      docRef.get().then(
                            (DocumentSnapshot doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          print(data['pw']);





                          // if(docRef.exists == true){
                          //   AwesomeDialog(
                          //     context: context,
                          //     dialogType: DialogType.error,
                          //     borderSide: const BorderSide(
                          //       color: Colors.green,
                          //       width: 2,
                          //     ),
                          //     width: 280,
                          //     buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                          //     dismissOnTouchOutside: true,
                          //     dismissOnBackKeyPress: false,
                          //     headerAnimationLoop: false,
                          //     animType: AnimType.BOTTOMSLIDE,
                          //     title: 'Inof',
                          //     desc: "아이디를 확인해주세요.",
                          //     showCloseIcon: true,
                          //     btnOkOnPress: (){},
                          //   ).show();
                          // }


                          if(inputPW.text == data['pw'].toString()){
                            context.read<Store1>().changeName(inputId.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => secondMain()),
                            );
                          }else{
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                              width: 280,
                              buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              headerAnimationLoop: false,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Inof',
                              desc: "비밀번호를 확인해주세요.",
                              showCloseIcon: true,
                              btnOkOnPress: (){},
                            ).show();
                          }


                          // ...
                        },

                        onError: (e) => print("Error getting document: $e"),
                      );


                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    // width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't you have an account?"),
                        TextButton(
                          onPressed: () {
                            // todo register
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
