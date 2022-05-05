import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    Widget notificationList(String title,String subtitle,) {
      return ListTile(
        leading: Icon(
          Icons.notifications,
          size: 25,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(subtitle,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        ),
        isThreeLine: true,
        
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          notificationList(
            'Plastic bag',
            'Abebe is interested in your Product, if you want to contact him click here'
          ),
          notificationList('Announcement',
              'Dear Yishak, Fridy Morning 3:00 LT waste will be collected'),
           notificationList('Report Resolved',
              'Dear Yishak, Your Report on Broken pipe on location Gerji is resolved'),    
        ],
      ),
    );
  }
}
