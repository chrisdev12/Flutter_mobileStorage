import 'package:flutter/material.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';
import 'package:user_preferences/src/widgets/drawer.dart';

class HomePage extends StatelessWidget {

  final prefs = new Preferences();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor: (prefs.secondColor) ? Colors.red: Colors.teal ,
      ),
      drawer: drawerWidget(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Color primario: ${prefs.secondColor}'),
          Divider(),
          Text('Genero: ${prefs.genre}'),
          Divider(),
          Text('Nombre Usuario: : ${prefs.name}'),
          Divider(),
        ],
      ),
    );
  }
}