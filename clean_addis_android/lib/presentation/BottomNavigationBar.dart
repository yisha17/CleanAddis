import 'package:clean_addis_android/presentation/Login.dart';
import 'package:clean_addis_android/presentation/NotifyMap.dart';
import 'package:clean_addis_android/presentation/Profile.dart';
import 'package:clean_addis_android/presentation/Signup.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'Home.dart';
import 'Report.dart';
import 'Setting.dart';

class Pages extends StatefulWidget {
  PagesState createState() => PagesState();
}

class PagesState extends State<Pages> {
int selectedIndex = 0;
PageController pageController = PageController();
  var screen = [
HomePage(),
SettingsPage(),
ReportPage(),
EditProfilePage(),

];

void onTapped(int index) {
    setState(() => 
    selectedIndex = index
    );
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.bounceInOut);

  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:screen[selectedIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Sell'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Profile'),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: logogreen,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: onTapped,
      ),
    );
  }
}