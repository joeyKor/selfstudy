import 'package:flutter/material.dart';
import 'package:selfstudy/Page/ListUI.dart';
import 'package:selfstudy/Page/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:selfstudy/Store/sotre1.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  var formatted = "";
  var storage;
  var _url;


  getData() async{
     storage = await SharedPreferences.getInstance();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('EEEE, MMMM d, yyyy ');
    formatted = formatter.format(now);
    getData();
  // print(formatted);
  }


  // 홈화면에 사진 띄우기
  Future<String> setImage() async{
    var name2 =context.watch<Store1>().name;
    SharedPreferences pref = await SharedPreferences.getInstance();
    _url = pref.getString(name2);

    return _url;
  }


  @override
  Widget build(BuildContext context) {
    var Url;

    // context.read<Store1>().addUser('YangMinJi', 'https://firebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/yangminji.png?alt=media&token=5cee31a6-d6dd-4d05-93c7-c8b5f7ceef5c');
    // context.read<Store1>().addUser('a', 'wefebasestorage.googleapis.com/v0/b/self-study-7a60b.appspot.com/o/yangmi');
    // print('this this this');
    // print(context.watch<Store1>().users['YangMinJi']);
    // print('this this this');


    // Url = context.watch<Store1>().users[context.watch<Store1>().name].toString();

    // var name2 =context.watch<Store1>().name;


    // Url = "a";
    // Url = storage.get[name2];

    // print('thisthis thiaaaaaaas');
    // print(Url);
    // print('thisthis thiaaaaaaas');

    return FutureBuilder(future: setImage(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot){
    if (snapshot.hasData){
      return  ChangeNotifierProvider(
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
                                  backgroundImage: NetworkImage(_url),

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
    }else return CircularProgressIndicator();
    });


  }
}
