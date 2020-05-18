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
    print('${response.body}');
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
      var textstyle = TextStyle(
      fontSize: 20,
      foreground: Paint()
          ..style = PaintingStyle.fill 
          ..strokeWidth = 0.5
          ..color = Colors.black
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Student"),
      ),
      body: Center(
                child:studentd != null?Container(
                  width: double.infinity,
                  color: Colors.purple[50],
                  child:Flex(
                 direction: Axis.vertical,
                 mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("CourseId: "+ studentd.courseId.toString(), style: textstyle),
                                        Text("Name: "+ studentd.name, style: textstyle),
                                        Text("Email: "+ studentd.email, style: textstyle),
                                        Text("Username: "+ studentd.username, style: textstyle),
                                        Text("Phone: "+ studentd.phone, style: textstyle),
                                        Text("City: "+ studentd.city, style: textstyle),
                                        Text("Country: "+ studentd.country, style: textstyle),
                                        Text("Birthday: "+ new DateFormat("dd-MM-yyyy").format(DateTime.parse(studentd.birthday)), style: textstyle),
                                      ],
                                    ))
                                    
                            ],
                        )
                ):CircularProgressIndicator()   
                )
    );
  }
}
    