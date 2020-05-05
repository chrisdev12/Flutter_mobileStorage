import 'dart:async';
import 'package:user_preferences/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  ///[BehaviorSubject] had the broadcast as default. We should use that because StremController doesnt exit in rxDart

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>(); 

  //Recover streamData
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidStream => CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);
  
  //Insert values to the stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Last value inserted on the strems

  String get emailVal => _emailController.value;
  String get passwordVal => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}