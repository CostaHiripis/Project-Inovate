import 'package:CheckOff/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'register.dart';
import 'services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  var authHandler = new Auth();
  @override
  Widget build(BuildContext context) {
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
                        Image.asset("images/logoBlue.png",height: 200,width: 200,),
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
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                  Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            authHandler
                                .handleSignInEmail(email, password)
                                .then((FirebaseUser user) {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new MainScreen()));
                            }).catchError((e) => print(e));
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
