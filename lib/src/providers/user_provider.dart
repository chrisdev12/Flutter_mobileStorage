import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider{

  final String _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBzDF2Yivo8AHoRbxpB9vh_k7YVZUDBGOc';

  Future newUser(String email, String password )async {

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
      return {'ok': true};
    } else {
      return {'ok': false};
    }
  }
}