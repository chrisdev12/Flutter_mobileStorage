import 'package:flutter/material.dart';


Drawer drawerWidget(BuildContext context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/original.jpg'),
              fit: BoxFit.cover
            )
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          trailing: Icon(Icons.people),
          title: Text('Home'), 
          onTap: () => Navigator.pushReplacementNamed(context, 'home'), 
        ),
        /**
         * [PushReplacementNamed] a diferencia de [popAndPushNamed] me permite navegar a una pagina, 
         * pero no me hbailita la opción de devolverme.
         * De forma que era nueva pagina será la que funcione por defecto
         */
        ListTile(
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.people),
          title: Text('settings'),
          onTap: () => Navigator.pushReplacementNamed(context, 'settings'), 
        ),
        ListTile(
          leading: Icon(Icons.security),
          trailing: Icon(Icons.people),
          title: Text('Login'),
          onTap: () => Navigator.pushNamed(context, 'form'), 
        ),
        ListTile(
          leading: Icon(Icons.category),
          trailing: Icon(Icons.people),
          title: Text('Products'),
          onTap: () => Navigator.pushNamed(context, 'products'), 
        )
      ],
    ),
  );
}