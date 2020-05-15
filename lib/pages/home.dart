import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginnavigation/models/courselistitem.dart';
import 'package:loginnavigation/pages/coursedetail.dart';
import 'package:loginnavigation/userdata.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
  const Home({Key key, this.userdata}) : super(key: key);

  final UserData userdata;
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  var courses = new List<CourseLI>();

  _getCourses({String username, String token}) async {
    final http.Response response = await http.get(
      'https://movil-api.herokuapp.com/$username/courses',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print('${response.body}');
    print('${response.statusCode}');
    setState(() {
      Iterable list = json.decode(response.body);
      courses = list.map((model) => CourseLI.fromJson(model)).toList();
      /* Course c = Course.fromJson(json.decode(response.body));
      courses.add(c); */
    });
  }

    _addCourses({String username, String token}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/$username/courses',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print('${response.body}');
    print('${response.statusCode}');
    setState(() {
      /* Iterable list = json.decode(response.body);
      courses = list.map((model) => Course.fromJson(model)).toList(); */
      CourseLI c = CourseLI.fromJson(json.decode(response.body));
      courses.add(c);
    });
  }

  _deleteDB({String username, String token}) async {
    final http.Response response = await http.get(
      'https://movil-api.herokuapp.com/$username/restart',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print('${response.body}');
    print('${response.statusCode}');
    setState(() {
      /* Iterable list = json.decode(response.body);
      courses = list.map((model) => Course.fromJson(model)).toList(); */
      /* Course c = Course.fromJson(json.decode(response.body));
      courses.add(c); */
      courses.clear();
    });
  }

  initState() {
    super.initState();
    _getCourses(username: widget.userdata.username, token: widget.userdata.token);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
                child:Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                            Flexible(
                              flex:1,
                              child: Container(
                                child:Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text("Name: "+widget.userdata.name),
                                    Text("Username: "+ widget.userdata.username),
                                    Text("Email: "+ widget.userdata.email),
                                    Text("Status: " + (widget.userdata.logged ?"Logged":"Disconnected")),
                            ]))),
                            Flexible(
                              flex:1,
                              child: RaisedButton(
                              onPressed: () {
                                formatData(widget.userdata, "", "");
                                },
                                child: Text("Log out"),
                                ),
                            ),
                            Flexible(
                              flex:1,
                              child: RaisedButton(
                              onPressed: () {
                                _deleteDB(username: widget.userdata.username, token: widget.userdata.token);
                                },
                                child: Text("Delete DB"),
                                ),
                            ),
                          ]),
                          Expanded(
                            child:ListView.builder(
                            shrinkWrap: false,
                            itemCount: courses.length,
                            itemBuilder: (context,index){
                            return ListTile(
                              title: Text(courses[index].name),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Coursedetail(course: courses[index], userdata: widget.userdata),
                                  ),
                                );    
                              },
                              );
                          })                         
                          )
                            ],
                        )   
                ),
                floatingActionButton: Consumer<UserData>(builder: (context, userdata, child){
                  return FloatingActionButton(
                  onPressed: () async {
                    _addCourses(username: widget.userdata.username, token: widget.userdata.token);
                  },
                  tooltip: 'Add task',
                  child: new Icon(Icons
              .add));
                },),
    );
  }
}


void formatData(UserData userData, String email, String token) {
    userData.changeValue("", "", false, "", "", false);
}
    