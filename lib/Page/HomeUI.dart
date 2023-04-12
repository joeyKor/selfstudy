import 'package:flutter/material.dart';
import 'package:selfstudy/Page/ListUI.dart';
import 'package:selfstudy/Page/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:selfstudy/Store/sotre1.dart';
import 'package:intl/intl.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  var formatted = "";

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('EEEE, MMMM d, yyyy ');
    formatted = formatter.format(now);
  // print(formatted);
  }
  @override
  Widget build(BuildContext context) {

    var Url ='';

    if(context.watch<Store1>().name == 'YangMinJi'){
      Url = 'https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/yangminji.png?alt=media&token=5cee31a6-d6dd-4d05-93c7-c8b5f7ceef5c';
    }else if(context.watch<Store1>().name== 'KimJuYeong'){
      Url ='https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/kimjuyoung.png?alt=media&token=f1385eac-4209-46f1-b504-f8f586299ca1';
    }else{
      Url ='https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/teacher.png?alt=media&token=c5884651-3d0b-4df0-bfa1-390449aecf31';
    };

    return ChangeNotifierProvider(
      create: (c) => Store1(),
      child: Scaffold(
        backgroundColor: Colors.blue[800],
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(
                              'Hi, ${context.watch<Store1>().name}!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24
                              ),
                            ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                formatted.toString(),
                                style: TextStyle(color: Colors.blue[200]),
                              )]
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: CircleAvatar(
                            radius: 30.0,
                            // backgroundImage:AssetImage('${context.watch<Store1>().image}'),
                            backgroundImage: NetworkImage(Url),

                          )
                        )
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('About Our Story',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.more_horiz,color: Colors.white,)

                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListUI(),
                ),
              )



            ],
          ),
        )
      ),
    );
  }
}
