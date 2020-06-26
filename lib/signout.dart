import 'package:flutter/material.dart';

class SignoutScreen extends StatefulWidget {
  SignoutScreen({Key key}) : super(key: key);
  @override
  _SignoutScreenState createState() => _SignoutScreenState();
}

class _SignoutScreenState extends State<SignoutScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Center(
        child:RaisedButton(
          onPressed: (){
            return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Do you want to exit this application?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                     },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () async {
                        //#################### SIGN OUT HERE ####################//
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ??
                false;
          },
          color: Colors.cyan,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0))),
          child: Text(
            "Signout",
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}
