import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  var collec = '김주영';
  var time =["time"];
  var level = ['level'];

  getData() async{

    // await firestore.collection('product').add({'name':'under', 'price':300});

    var result = await firestore.collection(collec).orderBy("레벨", descending: true).get();
    for (var doc in result.docs){
      time.add(doc['시간']);
      level.add(doc['레벨']);

      // print(doc['시간']);
    }

      // var result = await firestore.collection('product').get();
      // for (var doc in result.docs){
      //   print(doc['name']);
      }
      // print(result['name']);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
      (
      stream: FirebaseFirestore.instance.collection(collec).snapshots(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
    return ListTile(
      leading: Text(collec),
    title: Text(
    snapshot.data!.docs[index].get('레벨'),
    ),
      subtitle: Text(
    snapshot.data!.docs[index].get('시간'),)
    );
    },
    );
    }
    if (snapshot.hasError) {
    return const Text('Error');
    } else {
    return const CircularProgressIndicator();
    }
    },
    );

  }
}
