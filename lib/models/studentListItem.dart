class StudentLI{
  int id;
  String name;
  String email;
  String username;
  StudentLI({this.id, this.name, this.email, this.username});

  factory StudentLI.fromJson(Map<String, dynamic> json) {
    return StudentLI(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username']
    );
  }

  Map toJson() {
    return {'id': id, 'name': name, 'email': email, 'username': username};
  }
}
