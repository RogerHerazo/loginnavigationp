import 'package:flutter/material.dart';
import 'package:loginnavigation/userdata.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
                child:Consumer<UserData>(builder: (context, userdata, child){             
               return Column(          
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(userdata.email),
                            ],
                          ),
                          RaisedButton(
                              onPressed: () {
                                formatData(userdata, "", "");
                                },
                                child: Text("Log out"),
                                )
                            ],
                            );
                            }    
                      )
                ),
    );
  }
}

void formatData(UserData userData, String email, String password) {
    userData.changeValue(email, password, false);
}