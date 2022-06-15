import 'package:clean_addis_android/presentation/Setting.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../bloc/Notification/notifications_bloc.dart';
import '../data/data_providers/notification_data.dart';
import '../data/repositories/notification_repo.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late IO.Socket socket;
  final notificationBloc = NotificationsBloc(
      repo: NotificationRepo(dataProvider: NotificationDataProvider()));
  void connect() async {
    var channel = IOWebSocketChannel.connect(
        Uri.parse('ws://192.168.1.7:8000/ws/notification/'));
    channel.stream.listen((message) {
      channel.sink.add('received!');
    });
  }

  @override
  void initState() {
    notificationBloc..add(NotificationPageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget notificationList(
        String title, String subtitle, Icon icon, Color color) {
      return ListTile(
        leading: icon,
        iconColor: color,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        isThreeLine: true,
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
      );
    }

    print('hello');

    return Scaffold(
      backgroundColor: lightgreen,
      appBar: AppBar(
        leading: Icon(
          Icons.notifications,
          size: 25,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            icon: Icon(Icons.settings),
            color: logogreen,
          )
        ],
        backgroundColor: lightgreen,
        centerTitle: true,
        elevation: 0,
        title: Text('Notifications',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            )),
      ),
      body: BlocBuilder(
          bloc: notificationBloc,
          builder: (context, state) {
            if (state is NotificationsInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [Center(child: CircularProgressIndicator())],
              );
            }
            if (state is NotificationListLoaded) {
              final notifications = state.notifications;
              if (notifications.isEmpty) {
                return Center(child: Text('There is nothing new'));
              } else {
                return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                    
                      switch (notifications.elementAt(index).type) {
                        case 'Waste':
                          {
                            return Dismissible(
                              key: ObjectKey(notifications.elementAt(index)),
                              child: notificationList(
                                  notifications.elementAt(index).waste_name!,
                                  'Hello ${notifications.elementAt(index).owner_name}, ${notifications.elementAt(index).buyer_name} is interested on ${notifications.elementAt(index).waste_name} posted on ${DateFormatter.changetoMD(notifications.elementAt(index).created_at!)}. Click here if you want to contact him',
                                  Icon(Icons.sell),
                                  Colors.black),
                            );
                          }
                        case 'Report':
                          {
                            return Dismissible(
                               key: ObjectKey(notifications.elementAt(index)),
                              child: notificationList(
                                  notifications.elementAt(index).report_title!,
                                  'Hello ${notifications.elementAt(index).owner_name}, your reported posted on ${DateFormatter.changetoMD(notifications.elementAt(index).created_at!)} is resolved. to see the report',
                                  Icon(Icons.report),
                                  Colors.black),
                            );
                          }
                        case "Announcement":
                          {
                            print( notifications.elementAt(index).address!);
                            return Dismissible(
                              key: ObjectKey(
                                  notifications.elementAt(index)),
                              child: notificationList(
                                  notifications.elementAt(index).address!,
                                  'Hello,${notifications.elementAt(index).message} ',
                                  Icon(Icons.send),
                                  Colors.black),
                            );

                          }
                        default:
                          {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Center(child: CircularProgressIndicator())
                              ],
                            );
                          }
                          
                      }
                      
                    }
                    
                    // children: [
                    //   notificationList(
                    //       'Plastic bag',
                    //       'Abebe is interested in your Product, if you want to contact him click here',
                    //       Icon(Icons.sell),
                    //       Colors.black),
                    //   Divider(),
                    //   notificationList(
                    //       'Announcement',
                    //       'Dear Yishak, Fridy Morning 3:00 LT waste will be collected',
                    //       Icon(Icons.send),
                    //       Colors.black),
                    //   Divider(),
                    //   notificationList(
                    //       'Report Resolved',
                    //       'Dear Yishak, Your Report on Broken pipe on location Gerji is resolved',
                    //       Icon(Icons.report),
                    //       Colors.black),
                    //   Divider(),
                    // ],
                    );
              }
            }
            return Center();
          }),
    );
  }
}
