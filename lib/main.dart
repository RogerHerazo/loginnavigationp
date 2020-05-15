import 'package:flutter/material.dart';
import 'pages/signup.dart';
import 'pages/login.dart';
import 'pages/home.dart';
import 'pages/app.dart';
import 'userdata.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

SharedPreferences prefs;
UserData user;

Future<bool> checkToken({String token}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/check/token',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': token
      }),
    );
    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      if (response.body == '{"valid":true}') {
        print("IsValid");
        return true;
      }else{
        print("NotValid");
        return false;
      }
    } else {
      return false;
    }
  }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  final name = prefs.getString("name");
  final username = prefs.getString("username");
  final useremail = prefs.getString("email");
  final usertoken = prefs.getString("token");
  final userlogged = prefs.getBool("logged");
  //log("User: " + useremail + " - Token: " + usertoken + " - Logged: " + userlogged.toString());
  if(useremail == null || usertoken == null || userlogged == null || name == null || username == null){
    user = new UserData(email: "", token: "", logged: false, name: "", username: "");
  }else{
    if (await checkToken(token: usertoken.trim())) {
      user = new UserData(email: useremail, token: usertoken, logged: userlogged, name: name, username: username);
    }else{
      user = new UserData(email: "", token: "", logged: false, name: "", username: "");
    }
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

