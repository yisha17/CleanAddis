import 'package:clean_addis_android/presentation/Notification.dart';
import 'package:clean_addis_android/presentation/PublicPlace.dart';

import 'package:clean_addis_android/presentation/SeminarList.dart';
import 'package:flutter/material.dart';
import '../utils.dart';
import 'Home.dart';
import 'ReporList.dart';
import 'Report.dart';

class Pages extends StatefulWidget {
  PagesState createState() => PagesState();
}

class PagesState extends State<Pages> {
  int selectedIndex = 0;
  PageController pageController = PageController();
  var screen = [
    HomePage(),
    NotificationPage(),
    PublicPlacePage(),
    ReportListPage(),
    SeminarListPage(),
  ];

  void onTapped(int index) {
    setState(() => selectedIndex = index);
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Public Place'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.diamond), label: 'Seminar'),

        ],
        currentIndex: selectedIndex,
        selectedItemColor: logogreen,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: onTapped,
      ),
    );
  }
}
