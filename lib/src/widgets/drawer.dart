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
          leading: Icon(Icons.markunread_mailbox),
          trailing: Icon(Icons.people),
          title: Text('Home'), 
          onTap: () => Navigator.pushReplacementNamed(context, 'home'), 
        ),
        ListTile(
          leading: Icon(Icons.pages),
          trailing: Icon(Icons.people),
          title: Text('Pages'),
          onTap: (){
            Navigator.popAndPushNamed(context, 'settings');
          } 
        ),

        /**
         * [PushReplacementNamed] a diferencia de [popAndPushNamed] me permite navegar a una pagina, 
         * pero no me hbailita la opción de devolverme.
         * De forma que era nueva pagina será la que funcione por defecto
         */

        ListTile(
          leading: Icon(Icons.pages),
          trailing: Icon(Icons.people),
          title: Text('settings'),
          onTap: () => Navigator.pushReplacementNamed(context, 'settings'), 
        )
      ],
    ),
  );
}