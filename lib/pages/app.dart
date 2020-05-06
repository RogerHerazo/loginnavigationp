import 'package:flutter/material.dart';
import 'package:loginnavigation/pages/login.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:loginnavigation/userdata.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  AppState createState() {
    return AppState();
  }
}

class AppState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
              child: Consumer<UserData>(builder: (context, userdata, child){
                if(userdata.loading ?? false){
                  return Center(child: CircularProgressIndicator());
                }else{
                  if (userdata.logged ?? false) {
                    return Home(userdata: userdata);
                  } else {
                    return FirstRoute();
                  }
                }
}),
      ),
    );
  }
}