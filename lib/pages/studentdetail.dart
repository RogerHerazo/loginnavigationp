import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginnavigation/models/studentListItem.dart';
import 'package:loginnavigation/models/student.dart';
import 'package:loginnavigation/models/course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:loginnavigation/userdata.dart';
class Studentdetail extends StatefulWidget {
  const Studentdetail({Key key, @required this.student, @required this.userdata}) : super(key: key);

  final UserData userdata;
  final StudentLI student;
  @override
  StudentdetailState createState() {
    return StudentdetailState();
  }
}

class StudentdetailState extends State<Studentdetail> {
  var studentd;

_getStudentsDetail({String username, int, studentid, String token}) async {
    final http.Response response = await http.get(
      'https://movil-api.herokuapp.com/$username/students/$studentid',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print('${response.statusCode}');
    if(response.statusCode == 200){
      setState(() {
        studentd = Student.fromJson(json.decode(response.body));
      });
    }else{
      Navigator.pop(context);
    }
  }

  initState() {
    super.initState();
    _getStudentsDetail(username: widget.userdata.username, studentid: widget.student.id, token: widget.userdata.token);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
                child:studentd != null?Column(
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
                                    Text("CourseId: "+ studentd.courseId.toString()),
                                    Text("Name: "+ studentd.name),
                                    Text("Email: "+ studentd.email),
                                    Text("Username: "+ studentd.username),
                                    Text("Phone: "+ studentd.phone),
                                    Text("City: "+ studentd.city),
                                    Text("Country: "+ studentd.country),
                                    Text("Birthday: "+ new DateFormat("dd-MM-yyyy").format(DateTime.parse(studentd.birthday))),
                                    
                            ]))),
                          ]),
                            ],
                        ):CircularProgressIndicator()   
                )
    );
  }
}
    