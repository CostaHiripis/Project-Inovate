import 'dart:convert';
import 'package:CheckOff/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'registerBuffer.dart';
import 'login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:password/password.dart';

class RegisterScreen extends StatefulWidget {
  // final Function toggleView;
  // RegisterScreen({this.toggleView});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String userName = '';
  String password = '';

  final storage = new FlutterSecureStorage();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
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
                                      autofocus: true,
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
                              Icon(Icons.person,
                                  color: Colors.white70, size: 40),
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
                                      validator: (val) => val.isEmpty
                                          ? 'Enter a username'
                                          : null,
                                      onChanged: (val) {
                                        setState(() {
                                          userName = val;
                                          print(userName);
                                        });
                                      },
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Name",
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
                  Container(
                    // color: Colors.black,
                    child: RaisedButton(
                      onPressed: () async {
                        try{
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _auth.registerWithEmailAndPassword(email, userName, hash);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerBuffer()),);
                            if (result == null || result.contains(" ")) {
                              setState(() => error = 'Enter valid email');
                            }
                          }
                        }
                        on PlatformException catch(e){
                          if(e.code == "ERROR_INVALID_EMAIL") {
                            print(e);
                           setState(() => error = 'Enter valid email!');
                          }
                        }catch (e) {
                          if(e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
                            print(e);
                            setState(() => error = 'Email already in use!');
                          }
                        };
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
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new LoginScreen()));
                      },
                      color: Colors.cyan,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.white70, size: 30),
                    ),
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
