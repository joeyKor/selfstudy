import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Store1 extends ChangeNotifier{
  var name ='john kim';
  var image ='assets/person.png';

  changeName(a){
    name = a;
    image = '${a}.png';
    notifyListeners();
  }

}