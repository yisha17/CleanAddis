

import 'dart:convert';

import 'package:clean_addis_android/data/models/notification.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:http/http.dart' as http;
class NotificationDataProvider{


  Future<List<Notification>?> getNotification(String id,String token) async{

    final response = await http.get(Uri.http(base_url,'api/announcement/$id'),
    headers: {
      'Authorization': 'JWT $token',
    });
  if (response.statusCode == 200) {
    final notification = jsonDecode(response.body) as List;
    List<Notification>? noteList = notification.map((e) => Notification.fromJSON(e)).toList();
    return noteList;
  }else{
    throw Exception('errror');
  }

  }
}