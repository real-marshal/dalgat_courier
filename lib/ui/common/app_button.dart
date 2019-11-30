import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AppButton(this.text, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.teal,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0)),
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
