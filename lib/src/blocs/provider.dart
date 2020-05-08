import 'package:flutter/material.dart';
import 'package:user_preferences/src/blocs/login.dart';
import 'package:user_preferences/src/blocs/products_bloc.dart';
export 'package:user_preferences/src/blocs/login.dart';

class Provider extends InheritedWidget{

  final loginBloc     = new LoginBloc();
  final _productsBloc = new ProductsBloc();
  static Provider _instance;

  ///With [singleton]
  factory Provider({Key key, Widget child}){
    if (_instance == null){
      _instance = new Provider._internal(key: key, child: child);
    }
    return _instance;
  }
  
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  //Without singleton
  // Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductsBloc products( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }
}
