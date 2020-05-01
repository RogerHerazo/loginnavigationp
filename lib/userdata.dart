import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class UserData extends ChangeNotifier{
  String email;
  String token;
  String name;
  String username;
  bool logged;
  UserData({this.email, this.token, this.logged, this.name, this.username});

  void changeValue(String e, String t, bool l, String n, String u){
    email = e;
    token = t;
    logged = l;
    name = n;
    username = u;
    notifyListeners();
    _savePreferences(e, t, l, n, u);
  }

  _savePreferences (String e, String t, bool l, String n, String u) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("email", e);
    prefs.setString("token", t);
    prefs.setBool("logged", l);
    prefs.setString("name", n);
    prefs.setString("username", u);
  }

  _printPreferences () async {
    final prefs = await SharedPreferences.getInstance();
    final useremail = prefs.getString("email");
    final usertoken = prefs.getString("token");
    final userlogged = prefs.getBool("logged");
    final realusername = prefs.getString("name");
    final fakeusername = prefs.getString("username");
    if(useremail == null || usertoken == null || userlogged == null || realusername == null || fakeusername == null){
      log("No saved user data");
    }else{
      log("User: " + useremail + " - Password: " + usertoken + " - Logged: " + userlogged.toString() + " - Name: " + realusername + " - UserName: " + fakeusername);
    }
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}
