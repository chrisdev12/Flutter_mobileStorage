import 'package:shared_preferences/shared_preferences.dart';

///[SharedPreferences.getInstance()] must have an unique instance.
///so, we showuld implement Singleton Pattern
///
class Preferences {

  static final Preferences _instance = new Preferences._internal();
    
  Preferences._internal();
 
  factory Preferences(){
    return _instance;
  }

  SharedPreferences _prefs;

  init() async{
    return _prefs = await SharedPreferences.getInstance();
  }

  get genre {
    return _prefs.getInt('genre') ?? 1;
  }

  set genre( int value){
    _prefs.setInt('genre', value);
  }

  get secondColor {
    return _prefs.getBool('secondColor') ?? false;
  }

  set secondColor( bool value){
    _prefs.setBool('secondColor', value);
  }

  get name {
    return _prefs.getString('name') ?? 'Pedro';
  }

  set name( String name){
    _prefs.setString('name', name);
  }

  //Store the last navigationPage open
  get lastPage{
    return _prefs.getString('page') ?? 'home';
  }

  set lastPage( String name){
    _prefs.setString('page', name);
  }

  //Token firebase
  get token{
    return _prefs.getString('token') ?? '';
  }

  set token( String token){
    _prefs.setString('token', token);
  }
}