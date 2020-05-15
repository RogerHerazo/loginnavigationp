class Professor{
  int id;
  String name;
  String email;
  String username;
  Professor({this.id, this.name, this.email, this.username});

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map toJson() {
    return {'id': id, 'name': name, 'email': email, 'username': username};
  }

  String toString(){
    return "ID: " + this.id.toString() + " Name: " + this.name + " Email: " + this.email + " Username: " + this.username;
  }
}
