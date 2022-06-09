
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
Future<String> getToken() async{
  String? token = await FirebaseMessaging.instance.getToken();
  return token!;
}

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    print(androidDeviceInfo.androidId);
    return androidDeviceInfo.androidId; // unique ID on Android
  }
  return null;
}


