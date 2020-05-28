import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:CheckOff/rating/rating.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => new _TestState();
}

class _TestState extends State<Test> {
  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return new Rating(
      rating: rating,
      onRatingChanged: (rating) => setState(() => this.rating = rating),
    );
  }
}
