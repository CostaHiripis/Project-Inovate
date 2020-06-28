import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage {

  var dateTime;
  var timeDelayed;
  var secondsTillNotification;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  void showNotification(String title, String body)async {
    await notification(title, body);
  }

  Future<void> notification(String title, String body)async {
    timeDelayed = dateTime.subtract(Duration(seconds: secondsTillNotification));
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('Channel_ID', 'Channel title', 'channel body', priority: Priority.High, importance: Importance.Max, ticker: 'test');
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(0, title, body, timeDelayed, notificationDetails);
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
}