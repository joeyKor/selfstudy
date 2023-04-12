import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:selfstudy/Store/sotre1.dart';
import 'package:quickalert/quickalert.dart';

final db = FirebaseFirestore.instance;
final stagram = db.collection('ygstargram');

class Ygstargram extends StatefulWidget {
   Ygstargram({Key? key}) : super(key: key);


  @override
  State<Ygstargram> createState() => _YgstargramState();

}

class _YgstargramState extends State<Ygstargram> {
  final _formKey = GlobalKey<FormState>();

  var inputDate = TextEditingController();
  var inputWeather = TextEditingController();
  var inputFeeling = TextEditingController();
  var inputStory = TextEditingController();

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    inputDate.dispose();
    inputWeather.dispose();
    inputFeeling.dispose();
    inputStory.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection('ygstargram').snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ChangeNotifierProvider(
              create: (c)=>Store1(),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [Form(
                      key: _formKey,
                      child: Column(

                        children:<Widget> [
                          SizedBox(height: 50,),
                          Text('${context.watch<Store1>().name} \u0027s Story',textAlign: TextAlign.start,style: TextStyle(
                              fontFamily:'omu', fontWeight: FontWeight.bold, color: Colors.indigo,
                          fontSize: 27),),
                          SizedBox(height: 10,),
                          TextFormField(
                              style: TextStyle(fontFamily: 'omu', fontSize: 15, fontWeight: FontWeight.bold),
                              controller: inputDate,
                              validator: (value){
                                if(value!.isEmpty){
                                  return '';
                                }
                                return null;
                              },
                              decoration:InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'date')  )
                          ,
                          SizedBox(height: 10,),
                          TextFormField(
                              style: TextStyle(fontFamily: 'omu', fontSize: 15, fontWeight: FontWeight.bold),
                              controller: inputFeeling,
                              validator: (value){
                                if(value!.isEmpty){
                                  return '';
                                }
                                return null;
                              },
                              decoration:InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'feeling')  ),
                          SizedBox(height: 10,),
                          TextFormField(
                              style: TextStyle(fontFamily: 'omu', fontSize: 15, fontWeight: FontWeight.bold),
                              controller: inputWeather,
                              validator: (value){
                                if(value!.isEmpty){
                                  return '';
                                }
                                return null;
                              },
                              decoration:InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'weather')  ),
                          SizedBox(height: 10,),
                          TextFormField(
                            onTap: (){
                              _scrollController.animateTo(120.0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                              style: TextStyle(fontFamily: 'dodam', fontSize: 21, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              controller: inputStory,
                              validator: (value){
                                if(value!.isEmpty){
                                  return '';
                                }
                                return null;
                              },
                              decoration:InputDecoration(
                                  filled: true,
                                  fillColor: Colors.limeAccent,
                                  border: OutlineInputBorder(),
                                  hintText: 'story')  )


                      ,
                          SizedBox(height: 20,),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    final data1 = <String, dynamic>{
                                      'id': context.read<Store1>().name,
                                      "date":inputDate.text,
                                      'weather': inputWeather.text,
                                      'feeling': inputFeeling.text,
                                      'story' :inputStory.text,
                                      'reply' :'',
                                    };
                                    NumberFormat formatter = new NumberFormat("00000");
                                    var num = formatter.format(snapshot.data!.docs.length);
                                    stagram.doc(num.toString()).set(data1);
                                    final _newValue = "";
                                    inputDate.value = TextEditingValue(
                                      text: _newValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: _newValue.length),
                                      ),
                                    );
                                    inputWeather.value = TextEditingValue(
                                      text: _newValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: _newValue.length),
                                      ),
                                    );

                                    inputFeeling.value = TextEditingValue(
                                      text: _newValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: _newValue.length),
                                      ),
                                    );

                                    inputStory.value = TextEditingValue(
                                      text: _newValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: _newValue.length),
                                      ),
                                    );

                                    //업로드 성공
                                    QuickAlert.show(context: context,
                                        type: QuickAlertType.success,
                                        title: '성~공',
                                        text: "입력하신 내용을 게시하였습니다.");
                                  };



                                }, child: Text('Upload', style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'omu'
                            ),)),
                          ),

                        ],

                      ),
                    ),

                    ]

                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }

        });
  }
}
