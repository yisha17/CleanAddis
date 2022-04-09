import 'package:clean_addis_android/presentation/AddWaste.dart';
import 'package:clean_addis_android/presentation/BottomNavigationBar.dart';
import 'package:clean_addis_android/presentation/Home.dart';
import 'package:clean_addis_android/presentation/NotifyMap.dart';
import 'package:clean_addis_android/presentation/Signup.dart';
import 'package:clean_addis_android/presentation/Login.dart';
import 'package:clean_addis_android/presentation/YourItem.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: NotifyPage(),
    );
  }
}

