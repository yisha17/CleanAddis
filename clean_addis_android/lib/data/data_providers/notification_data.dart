

import 'dart:convert';

import 'package:clean_addis_android/data/models/notification.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class NotificationDataProvider{

  

  Future<List<Notifications>?> getNotification(String id,String token) async{
    final _storage = FlutterSecureStorage();
    final owner = await _storage.read(key: 'id');
    final response = await http.post(Uri.http(base_url,'api/announcement/$id'),
    headers: {
      'Authorization': 'JWT $token',
    },body: {
      "address":"Nifas Silk",
      "owner":owner
    });
  if (response.statusCode == 200) {
    final notification = jsonDecode(response.body) as List;
    List<Notifications>? noteList = notification.map((e) => Notifications.fromJSON(e)).toList();
    return noteList;
  }else{
    throw Exception('errror');
  }

  }


  Future<void> notifySeller(String token, int owner) async {
    final _storage = FlutterSecureStorage();
    final buyer = await _storage.read(key: 'id');
    print(int.parse(buyer!));
    print(owner);
    final response =
        await http.post(Uri.http(base_url, 'api/announcement/'), headers: {
      'Authorization': 'JWT $token',
    }, body: {
      "buyer": buyer,
      "owner": owner.toString(),
      'notification_type': "Waste",
      "notification_title": "Waste wanted",
      "notification_body" : "your item requested"
    });

    if (response.statusCode == 201) {
      print("successful");
    } else {
      print("error");
    }
  }


  Future<void> isSeen(String token,String id) async{
    final response = await http.post(Uri.http(base_url,'api/announcement/$id/update/'),
    headers: {
      'Authorization': 'JWT $token',
    },body: {
      "is_seen": true
    });

    if (response.statusCode == 200){
    print("successful");
    }else{
      print("error");
    }

  }
 }



