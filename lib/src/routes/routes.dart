import 'package:flutter/material.dart';
import 'package:user_preferences/src/pages/home.dart';

Map<String, Widget Function(BuildContext)> routes(context){
  return {
    'home': (BuildContext context) => HomePage()
  };
}