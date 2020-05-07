import 'package:flutter/material.dart';

SnackBar mySnackbar(String message,IconData icon, Color color, int milisecDuration){

  final duration = milisecDuration | 500;
  return SnackBar(
    backgroundColor: color,
    duration: Duration(milliseconds: duration),
    content: Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 20.0),
        Text('$message')
      ],
    )
  );
}