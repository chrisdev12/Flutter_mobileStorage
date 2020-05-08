import 'package:flutter/material.dart';
import 'package:user_preferences/src/blocs/provider.dart';
import 'package:user_preferences/src/providers/user_provider.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';
import 'package:user_preferences/src/widgets/alertWidget.dart';
import 'package:user_preferences/src/widgets/drawer.dart';

class LoginValidationPage extends StatelessWidget {

  final user = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(context),
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _loginForm(context)
        ],
      ),
    );
  }
  
  Widget _createBackground(BuildContext context) {
    final prefs = new Preferences();
    final size = MediaQuery.of(context).size;

    final purpleBackground = Container(
      height: size.height * 0.4,
      width: double.infinity, 
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    final circles = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        purpleBackground,
        Positioned( top: 90.0, left: 30.0,child: circles),
        Positioned( top: -40.0, right: -30.0,child: circles),
        Positioned( bottom: -50.0, right: -10.0,child: circles),
        Positioned( bottom: 120.0, right: 20.0,child: circles),
        Positioned( bottom: -50.0, left: -20.0,child: circles),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height:10.0, width: double.infinity),
              Text(prefs.name, style: TextStyle(color: Colors.white, fontSize: 25.0),)
            ],
          ),
        )     
      ],
    );
  }

  Widget _loginForm(BuildContext context) {

    ///[Provider.of(context)] = Start a bottom-up search through the widgets on the Widget's three
    /// until found where Provider was init,[and then call his instance of LoginBloc]
    final bloc = Provider.of(context);
  
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(
            height: size.height * 0.25
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical:50.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 4.0),
                  spreadRadius: 2.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Login'),
                SizedBox(height: 30.0),
                _createEmail(bloc),
                SizedBox(height: 30.0),
                _createPassword(bloc),
                SizedBox(height: 30.0),
                _createButton(bloc)
              ],
            )
          ),
          _registerButton(context),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
      
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.blueAccent),
              hintText: 'Example@email.com',
              labelText: 'Email address',
              errorText: snapshot.error       
            ),
            onChanged: bloc.changeEmail
          ),
        );    
      }
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.blueAccent),
              labelText: 'Password',
              errorText: snapshot.error 
            ),
            onChanged:bloc.changePassword
          ),
        );
      }
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar')
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0) 
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? (){_login(context,bloc);} : null
        );
      }
    );
  }

  _login(BuildContext context,LoginBloc bloc) async {
    print('============');
    print('email: ${bloc.emailVal}');
    print('password: ${bloc.passwordVal}');

    final logInfo = await user.login(bloc.emailVal, bloc.passwordVal);

    if(logInfo['ok']){
      Navigator.pushReplacementNamed(context, 'logged');
    } else{
      showAlert(context,'Ups, verifica tus datos','Email o contraseña incorrectos, verifica de nuevo');
    }
  }

  Widget _registerButton(BuildContext context) {

    return FlatButton(
      onPressed: () => Navigator.pushNamed(context, 'register'),
      child: Text('Register now')
    );
  }
}