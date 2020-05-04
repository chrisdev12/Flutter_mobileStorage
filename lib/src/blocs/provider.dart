import 'package:flutter/material.dart';
import 'package:user_preferences/src/blocs/login.dart';
export 'package:user_preferences/src/blocs/login.dart';

class Provider extends InheritedWidget{

  final loginBloc = LoginBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    print('holi');
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
}
