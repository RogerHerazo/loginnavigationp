import 'package:flutter/material.dart';
import 'package:loginnavigation/models/professor.dart';

class Professordetail extends StatefulWidget {
  const Professordetail({Key key, @required this.professor}) : super(key: key);

  final Professor professor;
  @override
  ProfessordetailState createState() {
    return ProfessordetailState();
  }
}

class ProfessordetailState extends State<Professordetail> {
  initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Professor"),
      ),
      body: Center(
                child:Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                                    Text("Name: "+ widget.professor.name, style: TextStyle(fontSize: 20)),
                                    Text("Email: "+ widget.professor.email, style: TextStyle(fontSize: 20)),
                                    Text("Username: "+ widget.professor.username, style: TextStyle(fontSize: 20))
                                    
                            ],
                        )   
                )
    );
  }
}
    