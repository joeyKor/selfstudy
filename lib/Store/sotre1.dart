import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Store1 extends ChangeNotifier{
  var name ='john kim';
  var image ='assets/person.png';
  Map<String, dynamic> users = {'a':'abc'};

  addUser(user, url){
    users[user] = url;
    print('hi  this is add user $user ');
    print(users.length);
    notifyListeners();

  }

  changeName(a){
    name = a;
    notifyListeners();
  }

}