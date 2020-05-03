import 'package:flutter/material.dart';
import 'package:user_preferences/src/widgets/drawer.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: drawerWidget(context),
      body: ListView(
        children: <Widget>[
          Text('settings')
        ],
      )
    );
  }
}