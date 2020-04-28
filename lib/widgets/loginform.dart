import 'package:flutter/material.dart';
import 'package:loginnavigation/userdata.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                border: InputBorder.none,
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
Consumer<UserData>(builder: (context, userdata, child){
  return RaisedButton(
  onPressed: () {
    if (_formKey.currentState.validate()) {
      formatData(userdata, email.text, password.text);
    }
  },
  child: Text("Sign in"),
  );
}),
        ]
     )
    );
  }
}

void formatData(UserData userData, String email, String password) {
    userData.changeValue(email, password, true);
  }