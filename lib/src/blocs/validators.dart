import 'dart:async';

class Validators{

  final validatePassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink){
      if(password.length >= 6){
        sink.add(password);
      } else{
        sink.addError('More than 6 characters please');
      }
    }
  );

  final validateEmail= StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp reg = new RegExp(pattern);
      if(reg.hasMatch(email)){
        sink.add(email);
      } else{
        sink.addError('That is not an email format');
      }
    }
  );
}