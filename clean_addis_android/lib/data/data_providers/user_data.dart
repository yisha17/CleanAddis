import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/strings.dart';

class UserDataProvider {
  Future<User> signup(User user) async {
    final response = await http.post(Uri.http(base_url, user_signup_path),
        body: jsonEncode({
          'username': user.username,
          'email': user.email,
          'password': user.password,
        }));

    if (response.statusCode == 200) {
      return User.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('error');
    }
  }
}
