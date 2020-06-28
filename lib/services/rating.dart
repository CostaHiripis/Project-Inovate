import 'dart:async';

import 'package:CheckOff/app.dart';
import 'package:CheckOff/calendarpage.dart';
import 'package:CheckOff/reviewDisplay/design_course_app_theme.dart';
import 'package:CheckOff/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Rating extends StatefulWidget {
  final String passedDayOfEvent;
  final String documentID;
  final String taskName;
  final String userEmail;
  final Timestamp eventDay;
  final Timestamp postDate;
  Rating(
      {this.passedDayOfEvent,
      this.documentID,
      this.taskName,
      this.userEmail,
      this.eventDay,
      this.postDate});
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var rating = 3.0;
  // Auth auth = new Auth();

  String feedback = '';
  SmoothStarRating stars = new SmoothStarRating();
  void checkIfAssignmentWasCompleted() {
//We get Collection of 'userAssignments' from database
    final CollectionReference userAssignments =
        Firestore.instance.collection('userAssignments');

    userAssignments.document(this.widget.documentID).setData({
      'experience': this.feedback,
      'completed': true,
      'documentID': this.widget.documentID,
      'taskName': this.widget.taskName,
      'userEmail': this.widget.userEmail,
      'eventDayForCalendar': this.widget.passedDayOfEvent,
      'eventDay': this.widget.eventDay,
      'postDate': this.widget.postDate,
      'rating': this.rating
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.redAccent[50],
        body: SingleChildScrollView(
            child: Container(
      // color: Colors.red[200],
      decoration: BoxDecoration(
        gradient: LinearGradient(stops: [
          0.1,
          0.6,
        ], colors: [
          Colors.red[200],
          Colors.pink[50]
        ]),
        // border: new Border.all(color: Colors.white, width: 5.0),
        // borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            // color: Colors.black,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text('Tell us your experience \n with this task',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 20,
                    letterSpacing: 1.5)),
          ),
          // Divider(
          //   height: 20,
          //   color: Colors.pink,
          // ),
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
              color: DesignCourseAppTheme.nearlyWhite,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: DesignCourseAppTheme.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                SmoothStarRating(
                  rating: rating,
                  isReadOnly: false,
                  size: 40,
                  color: Colors.deepPurple[600],
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  borderColor: Colors.deepPurple[100],
                  starCount: 5,
                  allowHalfRating: false,
                  spacing: 2.0,
                  onRated: (value) {
                    this.rating = value;
                    print("rating value -> $value");
                    // print("rating value dd -> ${value.truncate()}");
                  },
                ),
                SizedBox(height: 60),
                Container(
                  // height: 100,
                  padding: EdgeInsets.all(10),
                  // color: Colors.blue,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Post your experience',
                    ),
                    onChanged: (val) {
                      setState(() {
                        feedback = val;
                        print(feedback);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                RaisedButton(
                    onPressed: () {
                      checkIfAssignmentWasCompleted();
                      Timer(Duration(seconds: 1), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(stops: [
                          0.1,
                          0.6,
                        ], colors: [
                          Colors.red[300],
                          Colors.pink[100]
                        ]),
                        // border: new Border.all(color: Colors.white, width: 5.0),
                        // borderRadius: new BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: const Text('Submit',
                              style: TextStyle(fontSize: 20))),
                    )),
                SizedBox(
                  height: 140,
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
