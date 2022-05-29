

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler{
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static BuildContext? myContext;

  static void initNotification(BuildContext context){
    myContext = context;
    var initAndroid = AndroidInitializationSettings("@mimap.ic_launcher");
  var initSetting = InitializationSettings(android: initAndroid);
  flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification:onSelectNotification);
  }

  static Future onSelectNotification(String? payload)async{
    if(payload != null) print('get payload');
  }

  static Future onDidRecieveLocalNotification(
    int id,String title, String body,String payload
  ) async{
    showDialog(context: myContext!, builder: (context) => 
    AlertDialog(title: Text(title),content: Text(body),actions: [
      TextButton(onPressed:(){
        Navigator.of(context,rootNavigator:true).pop();
      }, child: Text('OK'))
    ],));
  }
} 