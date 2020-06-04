import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  Icon fieldIcon;
  String hintText;
  bool obscureText;
  String _fieldValue;

  CustomInputField(this.fieldIcon, this.hintText, this.obscureText);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            fieldIcon,
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
                    obscureText: obscureText,
                    onSaved: (val) => _fieldValue = val,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: this.hintText,
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
    );
  }
}
