import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  // final Function toggleView;
  // TestPage({this.toggleView});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yo what's good homie :)"),
      ),
      body:
          Text("This is just an empty page for now, nothing special... yet ;)"),
    );
  }
}
