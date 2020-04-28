import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
              TextFormField(
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
      Scaffold
          .of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  },
  child: Text("Sign up"),
),

        ]
     )
    );
  }
}