import 'package:flutter_svg/svg.dart';
// import 'dart:html';
import 'package:flutter/material.dart';


class EngUI extends StatefulWidget {
  const EngUI({Key? key}) : super(key: key);

  @override
  State<EngUI> createState() => _EngUIState();
}

class _EngUIState extends State<EngUI> {
  @override
  Widget build(BuildContext context) {
    var eng = TextEditingController();
    var kor = TextEditingController();
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (c,i){
      return Card(
        child: ListTile(
          leading:Icon(Icons.abc_rounded),
          trailing: Image.asset('mic.png'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('SunDay',style: TextStyle(
                fontFamily: 'omu',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.blueAccent[700],),
              ),
              Text('일요일',style: TextStyle(
                fontFamily: 'omu',
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.grey[600],),
              ),

            ],
          ),

        ),
      );
    });


  }
}




// ListView.builder(
      // itemCount: 3,
      // itemBuilder: (c, i){
      //   return ListTile(
      //     title: Text('sunday'),
      //     trailing: Icon(Icons.abc),
      //   );
      // },),



