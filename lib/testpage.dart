import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  // final Function toggleView;
  // TestPage({this.toggleView});

  @override
  _TestPageState createState() => _TestPageState();
}

void showNotification() {}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yo what's good homie :)"),
      ),
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
//LOL robert
