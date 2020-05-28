import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  bool status = false;
  void pp() {
    onPressed:
    null;
  }

  bool initState() {
    if (status == false) {
      return false;
    } else {
      // status = false;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _onPressed = null;
    if (status) {
      _onPressed = () {
        print('tomek');
      };
    }
    List<int> buttonNumber = [];
    List<ButtonTheme> buttonsList = new List<ButtonTheme>();
    void loopNumber() {
      buttonNumber.forEach((element) {
        print(element);
      });
    }

    void disable() {}

    List<Widget> _buildButtons() {
      for (int i = 0; i < 5; i++) {
        buttonNumber.add(i);
        buttonsList.add(ButtonTheme(
          height: 20,
          minWidth: 40,
          child: FlatButton(
            color: Colors.white,
            onPressed: _onPressed,

            // onPressed: initState() ? null : () => pp(),
            child: Icon(Icons.star),
          ),
        ));
      }
      return buttonsList;
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('Rate the homework',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            Divider(
              height: 30,
              color: Colors.red,
            ),
            Row(
              // children: iconsImage.map((e) => Icon(e)).toList(),
              children: _buildButtons(),
            )
          ],
        ),
      ),
    );
  }
}
