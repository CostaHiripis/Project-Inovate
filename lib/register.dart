import 'package:CheckOff/UI/CustomInputField.dart';
import 'package:flutter/material.dart';

class registerScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: Colors.blue,
        child: Center(
          child: Container(
            width: 400,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomInputField(Icon(Icons.email,color: Colors.white70),"Email",false),
                CustomInputField(Icon(Icons.person,color: Colors.white70),"Name",false),
                CustomInputField(Icon(Icons.lock,color: Colors.white70),"Password",true),
                Container(
                  child: RaisedButton(onPressed: (){},color: Colors.cyan,textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Text("Register",style: TextStyle(
                    fontSize: 20.0
                  ),),),

                ),
              ],
            ),
          ),
        ),
      ),
    );
    }
}