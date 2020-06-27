import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}
List<String> notifications = List<String>();
var secondsTillNotification = 10;

List<String> getNotifications() {
  return notifications;
}

List<String> addNotifications(String name) {
  notifications.add(name);
}

class _NotificationsPageState extends State<NotificationsPage> {

  
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  void showNotification()async {
    await notification();
  }

  Future<void> notification()async {
    var timeDelayed = DateTime.now().add(Duration(seconds: secondsTillNotification));
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('Channel_ID', 'Channel title', 'channel body', priority: Priority.High, importance: Importance.Max, ticker: 'test');
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(0, 'test','Is it working', timeDelayed, notificationDetails);
  }

  @override
  void initState()
  {
    super.initState();
    initializing();
  }

  void initializing()async {
    androidInitializationSettings = AndroidInitializationSettings("app_icon");
    iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    if(payload != null) {
      print(payload);
    }
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async{
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print("");
          },
          child: Text("ok"),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: showNotification,
        child: new Icon(Icons.notifications),
      ),
    );
  }
}