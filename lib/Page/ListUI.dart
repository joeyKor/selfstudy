import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
// import 'dart:html';

final firestore = FirebaseFirestore.instance;
final db = FirebaseFirestore.instance;
final registerRef = db.collection("register");

class ListUI extends StatefulWidget {
  const ListUI({Key? key}) : super(key: key);

  @override
  State<ListUI> createState() => _ListUIState();
}

class _ListUIState extends State<ListUI> {

  var collec = 'ygstargram';
  var inputReply = TextEditingController();

  // var date = [];
  // var feeling = [];
  // var story = [];
  // var weather = [];

  var ID = [];
  var URL = [];

  getData() async {
    // var result = await firestore.collection('collec').get();
    var user = await firestore.collection('register').get();




    // for (var doc in result.docs){
    //   date.add(doc['date']);
    //   feeling.add(doc['feeling']);
    //   story.add(doc['story']);
    //   weather.add(doc['story']);

  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    inputReply.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width * 0.6;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
      (
      stream: FirebaseFirestore.instance.collection(collec).snapshots(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {

          return ListView.builder(

            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              int itemCount = snapshot.data!.docs.length ?? 0;
              int reversedIndex = itemCount - 1 - index;
              var Url = '';
              var inputID = snapshot.data!.docs[reversedIndex].get('id');

              if(snapshot.data!.docs[reversedIndex].get('id')== 'YangMinJi'){
                Url = 'https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/yangminji.png?alt=media&token=5cee31a6-d6dd-4d05-93c7-c8b5f7ceef5c';
              }else if(snapshot.data!.docs[reversedIndex].get('id')== 'KimJuYeong'){
                Url ='https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/kimjuyoung.png?alt=media&token=f1385eac-4209-46f1-b504-f8f586299ca1';
              }else{
                Url ='https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/teacher.png?alt=media&token=c5884651-3d0b-4df0-bfa1-390449aecf31';
              };

              // final docRef = db.collection("register").doc(snapshot.data!.docs[reversedIndex].get('id'));
              // docRef.get().then(
              //       (DocumentSnapshot doc) {
              //     final data = doc.data() as Map<String, dynamic>;
              //     // ...
              //         Url = data['url'];
              //         print(Url);
              //   },
              //   onError: (e) => print("Error getting document: $e"),
              // );


              // db.collection("register").where("ID", isEqualTo: "teacher").get().then(
              //       (querySnapshot) {
              //     print('hi');
              //   },
              //   onError: (e) => print("Error completing: $e"),
              // );


              // var docRef = db.collection("register").doc(inputID.text);
              // docRef.get().then(
              // (DocumentSnapshot doc) {
              //  final data = doc.data() as Map<String, dynamic>;
              //  Url = data['url'];
              // }
              // );

              // if( snapshot.data!.docs[reversedIndex].get('id') == "KimJuYeong"){
              //   Url =  'https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/kimjuyoung.png?alt=media&token=f1385eac-4209-46f1-b504-f8f586299ca1';
              // }else if( snapshot.data!.docs[reversedIndex].get('id') == "KimJuYeong")
              // {
              //   Url = 'https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/yangminji.png?alt=media&token=5cee31a6-d6dd-4d05-93c7-c8b5f7ceef5c';
              // };




              return GestureDetector(
                onTap: () {

                 showDialog(context: context, builder: (context) {



                    return Dialog(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            height: 550,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    snapshot.data!.docs[reversedIndex].get(
                                        'date').toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('written by : ${snapshot.data!
                                      .docs[reversedIndex]
                                      .get('id')
                                      .toString()}'
                                    ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.deepPurple[700],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Text('날씨: ${snapshot.data!
                                          .docs[reversedIndex]
                                          .get('weather')
                                          .toString()}'
                                        ,
                                        style: TextStyle(
                                          fontFamily: 'omu',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.green[700],
                                        ),
                                      )),
                                      SizedBox(width: 5,),
                                      Expanded(child: Text('기분: ${snapshot.data!
                                          .docs[reversedIndex]
                                          .get('feeling')
                                          .toString()}'
                                        ,
                                        style: TextStyle(
                                          fontFamily: 'omu',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.orange[700],
                                        ),
                                      )
                                        ,)
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),


                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Colors.limeAccent,
                                    child: Text(
                                      snapshot.data!.docs[reversedIndex].get(
                                          'story').toString(),
                                      style: TextStyle(
                                        fontFamily: 'dodam',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('teacher: Good!!'
                                    ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Colors.indigo,
                                    ),
                                  )
                                  ,


                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child:  TextField(controller: inputReply ,), flex: 5,),
                                      SizedBox(width: 5,),
                                      Expanded(child:  IconButton(onPressed: (){}, icon: Icon(Icons.send), ),flex: 1 ,),

                                    ],),

                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: -50,
                              child: CircleAvatar(radius: 50,
                                backgroundImage: NetworkImage(
                                    Url),))
                          // backgroundImage: AssetImage('${snapshot.data!.docs[reversedIndex].get('id')}.png'),))
                        ],
                      ),
                    );
                  }
                  );
                },
                child: Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(Url),

                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(snapshot.data!.docs[reversedIndex].get('date'),
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: width,
                              child: Text(maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                snapshot.data!.docs[reversedIndex]
                                    .get('story')
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[500]),
                              ),

                            ),
                          ],
                        ),

                      )
                    ],
                  ),
                ),
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