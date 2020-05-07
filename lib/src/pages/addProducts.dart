import 'package:flutter/material.dart';
import 'package:user_preferences/src/models/product_model.dart';
import 'package:user_preferences/src/providers/products_provider.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';
import 'package:user_preferences/src/utils/numValidator.dart' as utils;
import 'package:user_preferences/src/widgets/snackBar.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  ///[Update] Class instances was wrong placed on the Build and was generating a bug
  ///due that some methods cant access to their properties. Classes should be invoked here.

  final prefs = new Preferences();
  ///[KEY] for get a reference of our form and scaffold
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _saving = false;
  ProductModel product = new ProductModel();
  ProductsProvider api = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      product = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
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
          ///[Form widget] works in a similar way a HTML forms,
          /// allow us control his child with validators and to have a submit-button trigger 
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _createName(),
                SizedBox(height: 10.0),
                _createPrice(),
                SizedBox(height: 10.0),
                _createAvailable(),
                SizedBox(height: 20.0),
                _createButton(),
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
      initialValue:  product.title,
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
      ///[OnSave] is executed once time the form is submmited
      onSaved:(value) => product.title = value,
    );
  }

  Widget _createPrice() {

    return TextFormField(
      initialValue: product.value.toString(),
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
      onSaved:(value) => product.value = int.parse(value)
    );
  }

  Widget _createAvailable() {

    return SwitchListTile(
      value: product.available,
      title: Text('Availability'),
      onChanged: (value) => setState(() {
        print(value);
        product.available = value;
      })
    );
  }

  Widget _createButton() {

    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Theme.of(context).backgroundColor,
      textColor: Colors.white,
      icon: Icon(Icons.save, color: Colors.white),
      label: Text('Save'),
      onPressed: (_saving) ? null : _submit
    );
  }

  void _submit(){
    ///[formKey] is attached to the key defined in the Form.
    ///This function return a bool regards to the validator conditions.
    if(!formKey.currentState.validate()) return;
      
    ///[To fire the onSaved] that have the TextFormFields, this method should be called:
    formKey.currentState.save(); 

    //Disabled the button while the request is being processed to avoid multiple wrong request
    setState((){ _saving = true; });

    if (product.id == null){
      api.createProduct(product);
      scaffoldKey.currentState.showSnackBar(
        mySnackbar('Product created', Icons.done, Colors.greenAccent, 1000)
      );
    } else{
      api.updateProduct(product); 
      scaffoldKey.currentState.showSnackBar(
        mySnackbar('Product updated', Icons.update, Colors.blueGrey, 1000)
      );
    }

    Navigator.pop(context);
  }
}