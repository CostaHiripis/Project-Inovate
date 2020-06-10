import 'dart:async';
import 'package:flutter/material.dart';

import 'login.dart';

class registerBuffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                // color: Colors.red,
                child: Text(
                  "Register was successfull",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.done,
              color: Colors.white,
              size: 80,
            )
          ],
        ));
  }
}
// child: Text(
//   'You have successfully registerd',
//   textAlign: TextAlign.center,
//   overflow: TextOverflow.ellipsis,
//   style: TextStyle(fontWeight: FontWeight.bold),
// )
