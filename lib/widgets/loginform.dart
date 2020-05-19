import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loginnavigation/userdata.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool save = false;
  @override
  Widget build(BuildContext context) {
    
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        color: Colors.grey,
        child: Column(
        children: <Widget>[
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                labelText: 'Enter your email'
              ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                labelText: 'Enter your password'
              ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Row(children: <Widget>[
                Checkbox(value: save, onChanged: (bool newvalue){
                print(newvalue);
                setState(() {
                  save = newvalue;
                });
              },),
                Text("Recuerdame")
              ]),
Consumer<UserData>(builder: (context, userdata, child){
  return RaisedButton(
  onPressed: () {
    if (_formKey.currentState.validate()) {
      //formatData(userdata, email.text.trim(), password.text.trim());
      userdata.setRemember(save);
      signIn(email: email.text.trim(), password: password.text.trim(), userdata: userdata).then((user){}).catchError((error){
        userdata.setLoading(false);
              });
              userdata.setLoading(true); 
            }
          },
          child: Text("Sign in"),
          );
        }),
                ]
             ),
              )
            );
          }
        
          void _buildDialog(BuildContext context, String error) {
            showDialog(context: context,
            builder: (context){
              return AlertDialog(
                content: new Text("Error "+ error)
              );
            });
          }
}

void formatData(UserData userData, String email, String token, String name, String username, bool loading) {
    //log("Email: " + email + "Token: " + token + "Name: " + name + "Username: " + username);
    userData.changeValue(email, token, true, name , username, loading);
  }

void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Future<UserData> signIn({String email, String password, UserData userdata}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,'password': password
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      UserData userdataok = UserData.fromJson(json.decode(response.body));
      formatData(userdata, email, userdataok.token, userdataok.name, userdataok.username, false);
    } else {
      print("signup failed");
      print('${response.body}');
      throw Exception(response.body);
    }
  }

