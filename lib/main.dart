import 'package:flutter/material.dart';
import 'pages/signup.dart';
import 'pages/login.dart';
import 'pages/home.dart';
import 'pages/app.dart';
import 'userdata.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

SharedPreferences prefs;
UserData user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  final useremail = prefs.getString("email");
  final userpassword = prefs.getString("password");
  final userlogged = prefs.getBool("logged");
  log("User: " + useremail + " - Password: " + userpassword + " - Logged: " + userlogged.toString());
  if(useremail == null || userpassword == null || userlogged == null){
    user = new UserData(email: "", password: "", logged: false);
  }else{
    user = new UserData(email: useremail, password: userpassword, logged: userlogged);
  }

  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserData>(
            create: (context) => user,
            child: MaterialApp(
              title: 'Login Navigation',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: App(),
              routes: <String, WidgetBuilder> {
              '/signup': (BuildContext context) => SecondRoute(),
              '/signin': (BuildContext context) => FirstRoute(),
              '/home': (BuildContext context) => Home(),
              },
            )
  );
    
  }
}

