import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/strings.dart';

class UserDataProvider {
  Future<User> signup(User user) async {
    print(user);
    final response = await http.post(Uri.http(base_url, user_signup_path),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
        },
        body: jsonEncode({
          'username': user.username,
          'email': user.email,
          'password': user.password,
        }));
    print(response.statusCode);
    if (response.statusCode == 201) {
      return User.fromJSON(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Bad Request.');
    } else {
      throw Exception('error');
    }
  }

  Future<User> login(User user) async {
    final response = await http.post(Uri.http(base_url, user_login_path),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
        },
        body: jsonEncode({
          'username': user.username,
          'password': user.password,
        }));
    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJSON(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      print("exception throwed");
      throw Exception('Incorrect username or password');
    } else {
      throw Exception('error');
    }
  }
}
