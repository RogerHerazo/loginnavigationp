import 'package:flutter/material.dart';
import 'package:loginnavigation/userdata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();


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
                      controller: name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Name'
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Username'
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email'
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
                        border: InputBorder.none,
                        labelText: 'Enter your password'
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          signUp(email: email.text.trim(), password: password.text.trim() ,username: username.text.trim() ,name: name.text.trim()).then((user){});
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Sign up"),
                    ),
                  ]
      )
      )
    );
  }
}

Future<UserData> signUp({String email, String password, String username, String name}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,'password': password,'username': username,'name': name
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      print('${response.body}');
      return UserData.fromJson(json.decode(response.body));
    } else {
      print("signup failed");
      print('${response.body}');
     throw Exception(response.body);
    }
  }
