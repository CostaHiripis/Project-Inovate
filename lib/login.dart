import 'package:CheckOff/services/auth.dart';
import 'package:flutter/material.dart';
import 'register(V2).dart';
class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String email = '';
  String password = '';

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
            // color: Colors.amber,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // width: 400,
                    // height: 400,
                    // color: Colors.red,
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
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)),
                                ),
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
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)),
                                ),
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
                  Container(
                    // color: Colors.black,
                    child: RaisedButton(
                      onPressed: () async {
                        //---------\\LOGIN CODE HERE\\----------
                      },
                      color: Colors.cyan,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20.0),
                      ),
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
