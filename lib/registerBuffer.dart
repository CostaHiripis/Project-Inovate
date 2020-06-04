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
        body: Container(
        child:Text(
          'You have successfully registerd',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      )
    );

  }
}
