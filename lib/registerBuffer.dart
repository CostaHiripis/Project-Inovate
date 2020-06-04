import 'dart:async';
import 'package:CheckOff/login.dart';

import 'register(V2).dart';
import 'services/auth.dart';
import 'services/database.dart';
import 'package:flutter/material.dart';

class RegisterBuffer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Timer(Duration(seconds: 3), () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //   );
    // });
    return Scaffold(
        body: Container(
            child: Text(
      'You have successfully registerd',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold),
    )));
  }
}
// child: Text(
//   'You have successfully registerd',
//   textAlign: TextAlign.center,
//   overflow: TextOverflow.ellipsis,
//   style: TextStyle(fontWeight: FontWeight.bold),
// )
