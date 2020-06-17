import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class TestPage extends StatefulWidget {
  // final Function toggleView;
  // TestPage({this.toggleView});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;

  void showNotification() async{
    await notification();
  }

Future<void> notification() async{
  var androidPlatformChannelSpesifics = AndroidNotificationDetails("channel_ID", "channel name", "channel description", importance: Importance.Max, priority: Priority.High, ticker: "test ticker");
  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpesifics, iOSChannelSpecifics);
  
  await flutterLocalNotificationsPlugin.show(0, "hello", "test", platformChannelSpecifics, payload: "test");
}

  @override
  void initState()
  {
    super.initState();
    initializationSettingsAndroid = new AndroidInitializationSettings("app_icon");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Text("This is just an empty page for now, nothing special... yet ;)"),
          floatingActionButton: new FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Increment',
        child: new Icon(Icons.notifications),
      ),
    );
  }
}
//hentai