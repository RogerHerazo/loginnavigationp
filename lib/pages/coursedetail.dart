import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loginnavigation/models/courselistitem.dart';
import 'package:loginnavigation/models/course.dart';
import 'package:loginnavigation/pages/professordetail.dart';
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
        coursedtl = Course.fromJson(json.decode(response.body));
        students = coursedtl.students;
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
        title: Text("Course"),
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
                                    Text(widget.course.name,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    GestureDetector(
                                      child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      color: Colors.purple[100],
                                      child: Text(coursedtl.professor == null? "Loading...": coursedtl.professor.name, 
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    ),
                                    onTap: (){
                                      if(coursedtl.professor != null){
                                        Navigator.push(
                                        context,
                                          MaterialPageRoute(
                                            builder: (context) => Professordetail(professor: coursedtl.professor, userdata: widget.userdata),
                                          ),
                                        );
                                      }
                                    },
                                    )
                                    
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
    