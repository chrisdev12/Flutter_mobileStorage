import 'package:flutter/material.dart';
import 'package:user_preferences/src/routes/routes.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //Avoid bugs
  final prefs = new Preferences();
  await prefs.init();
  runApp(MyApp());
}
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