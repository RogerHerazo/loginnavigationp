import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginnavigation/models/courselistitem.dart';
import 'package:loginnavigation/models/student.dart';
import 'package:loginnavigation/models/course.dart';
import 'studentdetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loginnavigation/userdata.dart';
class Coursedetail extends StatefulWidget {
  const Coursedetail({Key key, @required this.course, @required this.userdata}) : super(key: key);

  final UserData userdata;
  final CourseLI course;
  @override
  CoursedetailState createState() {
    return CoursedetailState();
  }
}

class CoursedetailState extends State<Coursedetail> {
  var students = new List<dynamic>();
  var coursedtl = new Course();

  _getCourseDetail({String username, int courseID, String token}) async {
    final http.Response response = await http.get(
      'https://movil-api.herokuapp.com/$username/courses/$courseID',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print('${response.body}');
    print('${response.statusCode}');
    if(response.statusCode == 200){
      setState(() {
        Course coursedtl = Course.fromJson(json.decode(response.body));
        students = coursedtl.students;
        print(coursedtl.professor.toString());
      });
    }else{
      Navigator.pop(context);
    }
  }

  initState() {
    super.initState();
    _getCourseDetail(username: widget.userdata.username, courseID: widget.course.id, token: widget.userdata.token);
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
                                    Text("Id: "+widget.course.id.toString()),
                                    Text("Name: "+widget.course.name),
                                    Text("Profesor: "+ widget.course.professor),
                                    Text("Students: "+ widget.course.students.toString()),
                            ]))),
                          ]),
                          Expanded(
                            child:ListView.builder(
                            shrinkWrap: false,
                            itemCount: students.length,
                            itemBuilder: (context,index){
                            return ListTile(
                              title: Text(students[index].name),
                              subtitle: Text("Id: "+students[index].id.toString() +"\nEmail: "+ students[index].email +"\nUsername: "+ students[index].username),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Studentdetail(student: students[index], userdata: widget.userdata),
                                  ),
                                );
                              });
                          })                         
                          )
                            ],
                        )   
                )
    );
  }
}
    