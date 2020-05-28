import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class userPage extends StatefulWidget {
  @override
  _userPageState createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Container(
//          color:Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
//                  margin:EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("imgs/pobrane.jpg"),
                    radius: 40,
                  ),
                ),
              ),
              Divider(
                height: 60,
                thickness: 0.5,
                color: Colors.red,
              ),
              Container(
//              color:Colors.red,
                child: Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(
                  'Marek',
                  style: TextStyle(
                    color: Colors.amberAccent[200],
                    letterSpacing: 2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
//                  color: Colors.red,
                    child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text('Teacher/ \n Student',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(45, 0, 0, 0),
//                        color:Colors.amber,
                      child: Text('Student',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
//              color:Colors.red,
                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.mail,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
//                      color:Colors.amber,
                      child: Text('PapaNomaly@TigetToot.com',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
