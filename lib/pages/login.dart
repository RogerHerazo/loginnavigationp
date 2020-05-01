import 'package:flutter/material.dart';
import 'package:loginnavigation/userdata.dart';
import 'package:loginnavigation/widgets/loginform.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginForm(),
            GestureDetector(
          child: Text('Dont have an account yet? Sign Up',style: TextStyle(color: Colors.blue)),
          onTap: () {
            Navigator.pushNamed(context, '/signup');
          },
        ),
          ],
        ),
      ),
    );
  }
}



