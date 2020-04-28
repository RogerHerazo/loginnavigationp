import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class UserData extends ChangeNotifier{
  String email;
  String password;
  bool logged;
  UserData({this.email, this.password, this.logged});

  void changeValue(String e, String p, bool l){
    email = e;
    password = p;
    logged = l;
    notifyListeners();
    _savePreferences(e, p, l);
  }

  _savePreferences (String e, String p, bool l) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("email", e);
    prefs.setString("password", p);
    prefs.setBool("logged", l);
  }

  _printPreferences () async {
    final prefs = await SharedPreferences.getInstance();
    final useremail = prefs.getString("email");
    final userpassword = prefs.getString("password");
    final userlogged = prefs.getBool("logged");
    if(useremail == null || userpassword == null || userlogged == null){
      log("No saved user data");
    }else{
      log("User: " + useremail + " - Password: " + userpassword + " - Logged: " + userlogged.toString());
    }
  }
}