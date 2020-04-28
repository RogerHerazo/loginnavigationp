import 'package:flutter/material.dart';
import 'package:loginnavigation/pages/login.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:loginnavigation/userdata.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
              child: Consumer<UserData>(builder: (context, userdata, child){
                if (userdata.logged ?? false) {
                  return Home();
                } else {
                  return FirstRoute();
                }
}),
      ),
    );
  }
}