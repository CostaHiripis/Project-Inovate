import 'dart:async';

import 'package:CheckOff/app.dart';
import 'package:CheckOff/calendarpage.dart';
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
        backgroundColor: Colors.amber[200],
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              // color: Colors.black,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Tell us your experience \n with this homework',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontSize: 20, letterSpacing: 1.5)),
            ),
            Divider(
              height: 20,
              color: Colors.red,
            ),
            SizedBox(
              height: 40,
            ),
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
                  labelText: 'Post your feedback',
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
              height: 40,
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
                child: Text('Post', style: TextStyle(color: Colors.black))),
            // Container(
            //   child: Text("" + auth.returnCurrentUser()),
            // )
          ],
        )));
  }
}
