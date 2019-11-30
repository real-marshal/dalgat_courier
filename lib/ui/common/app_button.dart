import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final ButtonType buttonType;
  final ShapeBorder shape;
  final Function onPressed;

  AppButton(
      {@required this.text,
      this.buttonType = ButtonType.raised,
      shape,
      this.onPressed})
      : shape = shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            );

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 10,
      height: 40,
      child: buttonType == ButtonType.raised
          ? FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Theme.of(context).primaryColor,
              shape: shape,
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: onPressed,
            )
          : OutlineButton(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              shape: shape,
              child: Text(
                text,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: onPressed,
            ),
    );
  }
}

enum ButtonType {
  raised,
  secondary,
}
