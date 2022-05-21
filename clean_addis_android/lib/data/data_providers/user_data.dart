import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:http_parser/http_parser.dart';

class UserDataProvider {
  var dio = Dio();
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
    print(base_url);
    print(user_login_path);
    final response = await http.post(Uri.http(base_url, user_login_path),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
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

  Future<User> updateProfile(User user,String id, String token, File? file) async{
    dio.options.headers["authorization"] = "JWT ${token}";
    String imageFile = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
       'username': user.username != null,
       'email' : user.email,
       'password' : user.password,
       'phone' : user.phone,
        'profile': await MultipartFile.fromFile(file.path,
          filename: imageFile,contentType: new MediaType('image','jpg'))
    });

    final response = await dio.patch('$full_base_url',data: formData);
    User user_updated = User.fromJSON(response.data);
    if(response.statusCode == 200){
      return user_updated;
    }else{
      throw Exception('error');
    }
  }
}
