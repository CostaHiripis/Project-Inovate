import 'dart:async';
import 'package:CheckOff/services/auth.dart';
import 'package:CheckOff/services/database.dart';
import 'package:flutter/material.dart';
import 'package:password/password.dart';
import 'app.dart';
import 'register.dart';
import 'services/auth.dart';
import 'services/database.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // final DbSearch _dbSearch = DbSearch();
  final DatabaseService _dbServices = DatabaseService();

  final _formKey = GlobalKey<FormState>();
  String error = '';
  // var authHandler = new Auth();
  var auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (FirebaseAuth.instance.currentUser() != null) {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => HomeScreen()),
    //           (Route<dynamic> route) => false,
    //     );
    //   }
    // });
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Container(
            // color: Colors.amber,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Image.asset(
                          "images/logoBlue.png",
                          height: 170,
                          width: 170,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: Colors.white70,
                                size: 40,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                width: 275,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      validator: (val) =>
                                          val.isEmpty ? 'Enter an email' : null,
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                          print(email);
                                        });
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.lock, color: Colors.white70, size: 40),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                width: 275,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      validator: (val) => val.length < 8
                                          ? 'Enter a password 8+ chars long'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          password = val;
                                          print(password);
                                        });
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          color: Colors.cyan,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            //---------\\LOGIN CODE HERE\\----------

                            // _dbSearch.getUserAccount(email.replaceAll(
                            //     new RegExp(r"\s+\b|\b\s"), ""));
                            //We have to wait around one second for function to find email account

                            Timer(Duration(seconds: 1), () {
                              if (email.length == 0) {
                                print("Field for email is empty");
                              } else {
                                auth
                                    .handleSignInEmail(email, password)
                                    .then((FirebaseUser user) {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new HomeScreen()));
                                }).catchError((e) => print(e));

                                // if (Password.verify(
                                //     password, _dbSearch.userPassword)) {
                                //   Navigator.push(
                                //       context,
                                //       new MaterialPageRoute(
                                //           builder: (context) =>
                                //               new HomeScreen()));
                                // } else {
                                //   print("Wrong password");
                                // }
                              }
                            });
                          },
                          color: Colors.cyan,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
