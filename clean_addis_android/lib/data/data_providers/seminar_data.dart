

import 'dart:convert';

import 'package:clean_addis_android/data/models/seminar.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:http/http.dart' as http;
class SeminarDataProvider{

  Future<List<Seminar>?> getSeminar(String token) async{
    final response = await http.get(Uri.http(base_url,'$seminar_path'),
    headers: {
      'Authorization': 'JWT $token',
    });

    if (response.statusCode == 200){
      final seminar = jsonDecode(response.body) as List;
       List<Seminar>? seminarList =
          seminar.map((e) => Seminar.fromJSON(e)).toList();
       return seminarList;   
    } else {
      throw Exception('errror');
    }
  }
}