import 'package:flutter/material.dart';

showAlert(BuildContext context, String message, String content){

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(message),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ok')
          )
        ],
      );
    }
  );
}