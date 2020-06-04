import 'package:CheckOff/UI/CustomInputField.dart';
import 'package:CheckOff/register.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Container(
            width: 400,
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  "images/logoBlue.png",
                  height: 150,
                  width: 150,
                ),
                CustomInputField(
                    Icon(Icons.email, color: Colors.white70), "Email", false),
                CustomInputField(
                    Icon(Icons.lock, color: Colors.white70), "Password", true),
                Container(
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.cyan,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => registerScreen()),
                      );
                    },
                    color: Colors.cyan,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
