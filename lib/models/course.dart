import 'package:loginnavigation/models/studentListItem.dart';

import 'studentListItem.dart';
import 'professor.dart';

class Course{
  String name;
  Professor professor;
  List<dynamic> students;
  Course({this.name, this.professor, this.students});

  factory Course.fromJson(Map<String, dynamic> json) {
    List<dynamic> studentslist = json['students'].map((model) => StudentLI.fromJson(model)).toList();
    Professor professord = Professor.fromJson(json['professor']);
    return Course(
      name: json['name'],
      professor: professord,
      students: studentslist,
    );
  }

  Map toJson() {
    return {'name': name};
  }
}
