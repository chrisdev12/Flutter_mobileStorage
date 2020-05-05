import 'package:flutter/material.dart';
import 'package:user_preferences/src/blocs/provider.dart';

class LoggedExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Logged example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${bloc.emailVal}'),
          Divider(),
          Text('Password: ${bloc.passwordVal}'),
        ],
      ),
    );
  }
}