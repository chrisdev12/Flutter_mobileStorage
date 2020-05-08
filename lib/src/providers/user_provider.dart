import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:user_preferences/src/share_prefs/preferences.dart';

class UserProvider{

  final String _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBzDF2Yivo8AHoRbxpB9vh_k7YVZUDBGOc';
  final String _logUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBzDF2Yivo8AHoRbxpB9vh_k7YVZUDBGOc';
  final _prefs = new Preferences();
  Future <Map<String,dynamic>> newUser(String email, String password ) async {

    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final res = await http.post(
      _url,
      body: json.encode(authData)
    );

    Map<String,dynamic> decodedRes = json.decode(res.body);
    if (decodedRes.containsKey('idToken')){
      _prefs.token = decodedRes['idToken'];
      return {'ok': true,'token': decodedRes['idToken']};
    } else {
      return {'ok': false};
    }
  }

  Future <Map<String,dynamic>> login(String email, String password ) async {

    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final res = await http.post(
      _logUrl,
      body: json.encode(authData)
    );

    Map<String,dynamic> decodedRes = json.decode(res.body);
    if (decodedRes.containsKey('idToken')){
      _prefs.token = decodedRes['idToken'];
      return {'ok': true,'token': decodedRes['idToken']};
    } else {
      return {'ok': false};
    }
  }
}