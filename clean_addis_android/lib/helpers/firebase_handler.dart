
import 'dart:io';

import 'package:clean_addis_android/helpers/notification_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications{
  late FirebaseMessaging messaging;
  BuildContext? myContext;

  void setupFirebase(BuildContext context){
    messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(context);
    firebaseCloudMessageListener(context);
    myContext = context;
  }
  
  void firebaseCloudMessageListener(BuildContext context) async{
    
  NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    messaging.getToken().then((value) => print(value));

    FirebaseMessaging.onMessage.listen((remoteMessage) { 
      if(Platform.isAndroid){
      showNotification(remoteMessage.data['title'],remoteMessage.data['body']);
    }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) { 
      print('Recieve open app: $remoteMessage');
    });
    
  }


  static void showNotification(title,body) async{
    var androidChannel = AndroidNotificationDetails(
      'com.example.clean_addis_android',
      'Announcement',
      channelDescription:'Announcement',
      autoCancel: false,
      ongoing: true,
      importance: Importance.max,
      priority:Priority.high
    );

    var platform = NotificationDetails(
      android:androidChannel,
    );

    await NotificationHandler.flutterLocalNotificationsPlugin
    .show(0, title, body, platform,payload: 'My payload');
  }
}