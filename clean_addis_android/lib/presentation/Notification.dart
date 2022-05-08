import 'package:clean_addis_android/presentation/Setting.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    Widget notificationList(String title,String subtitle,Icon icon, Color color) {
      return ListTile(
        leading: icon,
        iconColor:color,
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
        trailing: Icon(Icons.arrow_right,color:Colors.blue),
        
      );
    }

    return Scaffold(backgroundColor: lightgreen,
      appBar: AppBar(
         leading: Icon(
          Icons.notifications,
          size: 25,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed:(){
              Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()));
            }, icon: Icon(Icons.settings),color: logogreen,)
        ],
        backgroundColor: lightgreen,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
             color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
          )
        ),
      ),
      body: ListView(
        children: [
          notificationList(
            'Plastic bag',
            'Abebe is interested in your Product, if you want to contact him click here',
            Icon(Icons.sell),
            Colors.black
          ),
          Divider(),
          notificationList(
            'Announcement',
            'Dear Yishak, Fridy Morning 3:00 LT waste will be collected',
            Icon(Icons.send),
            Colors.black),
          Divider(),    
           notificationList('Report Resolved',
              'Dear Yishak, Your Report on Broken pipe on location Gerji is resolved',
              Icon(Icons.report),
              Colors.black),
          Divider(),        
        ],
      ),
    );
  }
}
