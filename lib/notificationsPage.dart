import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}
List<String> notifications = List<String>();
var secondsTillNotification = 5;

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

AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('Channel_ID', 'Channel title', 'Channel body', importance: Importance.Max, priority: Priority.High, ticker: "test ticker");
IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);
await flutterLocalNotificationsPlugin.show(0, 'Hello there', "my dude", notificationDetails);
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

  Future onSelectNotification(String payLoad){
    if(payLoad!=null){
      print(payLoad);
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

    notifications = ["test1", "test2", "test3"];
    List<Widget> notificationsWidgets = List<Widget>();
    notifications.forEach((item) { 
      notificationsWidgets.add(
        Container(
          padding: const EdgeInsets.all(8.0), 
          child: Text(item),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: notificationsWidgets,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: showNotification,
        child: new Icon(Icons.notifications),
      ),
    );
  }
}