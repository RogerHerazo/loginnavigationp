class Student{
  int courseId;
  String name;
  String email;
  String username;
  String phone;
  String city;
  String country;
  String birthday;
  Student({this.name, this.email, this.username, this.courseId, this.phone, this.city, this.country, this.birthday});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      courseId: json['course_id'],
      phone: json['phone'],
      city: json['city'],
      country: json['country'],
      birthday: json['birthday']
    );
  }

  Map toJson() {
    return {'name': name, 'email': email, 'username': username};
  }
}
