import 'package:flutter/material.dart';
import 'package:loginnavigation/models/professor.dart';
import 'dart:io';
import 'package:loginnavigation/models/studentListItem.dart';
import 'package:loginnavigation/models/student.dart';
import 'package:loginnavigation/models/course.dart';
import 'package:loginnavigation/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:loginnavigation/userdata.dart';

class Professordetail extends StatefulWidget {
  const Professordetail({Key key, @required this.professor, @required this.userdata}) : super(key: key);

  final Professor professor;
  final UserData userdata;
  @override
  ProfessordetailState createState() {
    return ProfessordetailState();
  }
}

class ProfessordetailState extends State<Professordetail> {
  var professord;

  _getProfessorDetail({String username, int, professorid, String token}) async {
    final http.Response response = await http.get(
      'https://movil-api.herokuapp.com/$username/professors/$professorid',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print('${response.statusCode}');
    print('${response.body}');
    if(response.statusCode == 200){
      setState(() {
        professord = Student.fromJson(json.decode(response.body));
      });
    }else{
      Navigator.pop(context);
    }
  }

  initState() {
    super.initState();
    _getProfessorDetail(username: widget.userdata.username, professorid: widget.professor.id, token: widget.userdata.token);
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
        title: Text("Professor"),
      ),
      body: Center(
                child:professord != null?Container(
                  width: double.infinity,
                  color: Colors.purple[50],
                  child:Flex(
                 direction: Axis.vertical,
                 mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("CourseId: "+ professord.courseId.toString(), style: textstyle),
                                        Text("Name: "+ professord.name, style: textstyle),
                                        Text("Email: "+ professord.email, style: textstyle),
                                        Text("Username: "+ professord.username, style: textstyle),
                                        Text("Phone: "+ professord.phone, style: textstyle),
                                        Text("City: "+ professord.city, style: textstyle),
                                        Text("Country: "+ professord.country, style: textstyle),
                                        Text("Birthday: "+ new DateFormat("dd-MM-yyyy").format(DateTime.parse(professord.birthday)), style: textstyle),
                                      ],
                                    ))
                                    
                            ],
                        )
                ):CircularProgressIndicator()  
                )
    );
  }
}
    