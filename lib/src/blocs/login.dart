import 'dart:async';
import 'package:user_preferences/src/blocs/validators.dart';

class LoginBloc with Validators {

  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast(); 

  //Recover streamData

  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  
  //Insert values to the stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}