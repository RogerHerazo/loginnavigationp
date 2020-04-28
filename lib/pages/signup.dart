import 'package:flutter/material.dart';
import 'package:loginnavigation/widgets/signupform.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignUpForm(),
            GestureDetector(
          child: Text('Have an account? Sign In',style: TextStyle(color: Colors.blue)),
          onTap: () {
            Navigator.pop(context);
          },
        ),
          ],
        ),
      ),
    );
  }
}