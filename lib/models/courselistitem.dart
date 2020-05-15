class CourseLI{
  int id;
  String name;
  String professor;
  int students;
  CourseLI({this.id, this.name, this.professor, this.students});

  factory CourseLI.fromJson(Map<String, dynamic> json) {
    return CourseLI(
      id: json['id'],
      name: json['name'],
      professor: json['professor'],
      students: json['students'],
    );
  }

  Map toJson() {
    return {'id': id, 'name': name, 'professor': professor, 'students': students};
  }
}
