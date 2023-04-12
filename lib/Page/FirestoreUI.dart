import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

final cities = db.collection("cities");
final country = db.collection('country');
final dateFire = db.collection('date');
final stagram = db.collection('ygstargram');
var ygstagram = FirebaseFirestore.instance.collection('ygstargram').snapshots();
var leng =10;

DateTime now = new DateTime.now();
DateTime date = new DateTime(now.year, now.month, now.day);


class FirestoreUI extends StatefulWidget {
  const FirestoreUI({Key? key}) : super(key: key);


  @override
  State<FirestoreUI> createState() => _FirestoreUIState();
}

class _FirestoreUIState extends State<FirestoreUI> {

  getleng()async{

    leng = await ygstagram.length;
  }


  getData() async {

    final docRef = db.collection("cities").doc("BJ");
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data['country']);
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
    getleng();
    
  }

  setData() {

    final data1 = <String, dynamic>{
      "name": "San Francisco",
      "state": "CA",
      "country": "USA",
      "capital": false,
      "population": 860000,
      "regions": ["west_coast", "norcal"]  };
    cities.doc("SF").set(data1);



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setData();
  getData();


  }

  @override
  Widget build(BuildContext context) {
    var inputDate = TextEditingController();
    var inputWeather = TextEditingController();
    var inputFeeling = TextEditingController();
    var inputStory = TextEditingController();

    return Container(
      child:Column(
        children: [
          TextField(controller: inputDate, decoration:InputDecoration(hintText: 'date')  ),
          TextField(controller: inputWeather,decoration:InputDecoration(hintText: 'weather')),
          TextField(controller: inputFeeling,decoration:InputDecoration(hintText: 'feeling')),
          TextField(controller: inputStory,decoration:InputDecoration(hintText: 'story')),

          Text(date.day.toString()),
          ElevatedButton(onPressed: (){

          }, child: Text('confirm')),
          ElevatedButton(onPressed: (){
            final data1 = <String, dynamic>{
              "date":inputDate.text,
              'weather': inputWeather.text,
              'feeling': inputFeeling.text,
              'story' :inputStory.text,
            };



            stagram.doc(leng.toString()).set(data1);
            getleng();

          }, child: Text('stagram Upload'))

        ],
      ),
    );
  }
}
