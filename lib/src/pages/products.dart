import 'package:flutter/material.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';
import 'package:user_preferences/src/utils/numValidator.dart' as utils;

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new Preferences();
    ///[KEY] for get a reference of our form
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products'
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: (){}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: (){} )
        ],
      ),
      floatingActionButton: _floatButton(context,prefs),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _createName(),
                SizedBox(height: 10.0),
                _createPrice(),
                SizedBox(height: 20.0),
                _createButton(context,formKey),
              ]
            )
          ),
        )
      )    
    );
  }

  Widget  _floatButton(BuildContext context,Preferences prefs) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){},
      backgroundColor: Theme.of(context).backgroundColor
    );
  }

  Widget _createName() {

    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product'
      ),
      validator: (value){
        if(value.length < 3){
          return 'Please insert the product name';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createPrice() {

    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal:true),
      decoration: InputDecoration(
        labelText: 'Price'
      ),
      validator: (value){

        if (utils.isNumeric(value)){
          return null; 
        } else{
          return 'Only numbers';
        }
      },
    );
  }

  Widget _createButton(BuildContext context, key) {

    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Theme.of(context).backgroundColor,
      textColor: Colors.white,
      icon: Icon(Icons.save, color: Colors.white),
      label: Text('Save'),
      onPressed: () => _submit(key)
    );
  }

  void _submit(formKey){
    ///[formKey] is attached to the key defined in the Form.
    ///This function return a bool regards to the validator conditions.
    formKey.currentState.validate();
  }
}