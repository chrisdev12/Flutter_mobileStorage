import 'package:flutter/material.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';
import 'package:user_preferences/src/widgets/drawer.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _secondColor;
  int _genre;
  TextEditingController _textController;
  final prefs = new Preferences();

  /*
  * Text controller only allow static static member in the init of the class. 
  So, we should init that class from the initState of this class to fulfill this requrement 
  */  

  @override
  void initState(){
    super.initState();
    _textController = new TextEditingController(text: prefs.name);
    //Setters of preferences
    _genre = prefs.genre;
    _secondColor = prefs.secondColor;
  }

  _setSelectedRadio(int value) async{
    prefs.genre = value;
    _genre = value;
    setState(() {
    });
  }

  _setInputText(String value) async{
    prefs.name = value;
    setState(() {
    });
  }

  _setColor(bool value) async{
    prefs.secondColor = value;
    _secondColor = value;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: (prefs.secondColor) ? Colors.red: Colors.teal
      ),
      drawer: drawerWidget(context),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'settings',
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Divider(),
          SwitchListTile(
            value: _secondColor,
            title: Text('Second color'),
            onChanged: _setColor
          ),
          RadioListTile(
            value: 1,
            title: Text('Masculine'),
            groupValue: _genre,
            onChanged: _setSelectedRadio
          ),
          RadioListTile(
            value: 2,
            title: Text('Femenine'),
            groupValue: _genre,
            onChanged: _setSelectedRadio
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal:20.0),
            child: TextField(
              controller: _textController,
              decoration:  InputDecoration(
                labelText: 'name',
                helperText: 'User name'
              ),
              onChanged: _setInputText
            )
          )
        ],
      )
    );
  }
}