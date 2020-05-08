import 'package:flutter/material.dart';
import 'package:user_preferences/src/pages/addProducts.dart';
import 'package:user_preferences/src/pages/form.dart';
import 'package:user_preferences/src/pages/home.dart';
import 'package:user_preferences/src/pages/logged.dart';
import 'package:user_preferences/src/pages/products.dart';
import 'package:user_preferences/src/pages/register.dart';
import 'package:user_preferences/src/pages/settings.dart';

Map<String, Widget Function(BuildContext)> routes(context){
  return {
    'home': (BuildContext context) => HomePage(),
    'settings': (BuildContext context) => SettingsPage(),
    'form' : (BuildContext context) => FormValidationPage(),
    'logged': (BuildContext context) => LoggedExample(),
    'products': (BuildContext context) => ProductPage(),
    'addProduct': (BuildContext context) => AddProductPage(),
    'register': (BuildContext context) => Register()
  };
}