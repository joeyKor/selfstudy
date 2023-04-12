import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class DialogUI extends StatefulWidget {
  DialogUI({Key? key}) : super(key: key);

  @override
  State<DialogUI> createState() => _DialogUIState();
}

class _DialogUIState extends State<DialogUI> {
  var inputDate = TextEditingController();
  var inputLevel =TextEditingController();
  var inputTime = TextEditingController();

  setData(a,b,c) async{
    await firestore.collection('김주영').add({'레벨': a, '시간':b, '날짜':c});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          TextField(controller: inputDate,),
          TextField(controller: inputLevel,),
          TextField(controller: inputTime,),
          ElevatedButton(onPressed: (){

          setData(inputTime.text, inputLevel.text, inputDate.text);

          }, child: Text('confirm')),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('exit')),
        ],
      ),
    );
  }
}
