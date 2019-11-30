import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;

  AppTextField({this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        style: TextStyle(color: Theme.of(context).accentColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54),
          fillColor: Colors.black54,
          filled: true,
          contentPadding: EdgeInsets.all(15),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
