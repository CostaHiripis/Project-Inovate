import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'login.dart';


class App extends StatelessWidget {
  @override
  //Build the app
  Widget build(BuildContext context) {
    //Returns the app to be displayed
    return MaterialApp(
        //Sets the theme for the app
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.blue),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          
        ),
        //These are properties for the MaterialApp class
        //This is the homescreen, scafold is used as a base for the app blocks
        home: LoginScreen());
  }
}
