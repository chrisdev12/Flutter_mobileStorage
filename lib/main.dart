import 'package:flutter/material.dart';
import 'package:user_preferences/src/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile storage',
      initialRoute: 'home',
      routes: routes(context),
    );
  }
}