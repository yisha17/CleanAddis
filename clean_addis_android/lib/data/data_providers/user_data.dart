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
    } else if (response.statusCode == 415) {
      throw Exception('Unsuported media type');
    } else {
      throw Exception('error');
    }
  }
}
