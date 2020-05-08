import 'package:flutter/material.dart';
import 'package:user_preferences/src/blocs/provider.dart';
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
    final prefs = new Preferences();

    ///[Provider] must be called here, nor in login to avoid null problem initialization
  
    return Provider(
        child: MaterialApp(
        theme: ThemeData(
          backgroundColor: (prefs.secondColor) ? Colors.red: Colors.teal
        ),
        debugShowCheckedModeBanner: false,
        title: 'Mobile storage',
        initialRoute: prefs.lastPage,
        routes: routes(context),
      ),
    );
  }
}