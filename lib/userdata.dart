import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier{
  String email;
  String token;
  String name;
  String username;
  bool logged;
  bool loading;
  bool remember;
  UserData({this.email, this.token, this.logged, this.name, this.username});

  void changeValue(String e, String t, bool l, String n, String u, bool lo){
    email = e;
    token = t;
    logged = l;
    name = n;
    username = u;
    loading = lo;
    notifyListeners();
    if (remember == true){
      print("Recuerda las preferencias");
      _savePreferences(e, t, l, n, u);
    }else{
      print("no recuerdes nada");
      _deletePreferences();
          }
        }
      
        void setLoading(bool lo){
          loading = lo;
          notifyListeners();
        }
      
        void setRemember(bool r) async {
          remember = r;
        }

        void setLogged(bool l){
          logged = l;
        }
      
        _savePreferences (String e, String t, bool l, String n, String u) async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("email", e);
          prefs.setString("token", t);
          prefs.setBool("logged", l);
          prefs.setString("name", n);
          prefs.setString("username", u);
        }
      
        factory UserData.fromJson(Map<String, dynamic> json) {
          return UserData(
            token: json['token'],
            username: json['username'],
            name: json['name'],
          );
        }
      
        _deletePreferences() async {
          final prefs = await SharedPreferences.getInstance();
          prefs.clear();
        }
}
