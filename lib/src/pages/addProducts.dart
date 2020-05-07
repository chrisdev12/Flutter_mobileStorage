import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:user_preferences/src/models/product_model.dart';
import 'package:user_preferences/src/providers/products_provider.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';
import 'package:user_preferences/src/utils/numValidator.dart' as utils;
import 'package:user_preferences/src/widgets/snackBar.dart';
import 'package:image_picker/image_picker.dart';
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
  File photo; //Retrieve the poho of ImagePicker

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
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: () => _selectImage(ImageSource.gallery)),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () => _selectImage(ImageSource.camera))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          ///[Form widget] works in a similar way a HTML forms,
          /// allow us control his child with validators and to have a submit-button trigger 
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _renderPhoto(),
                SizedBox(height: 10.0),
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

  void _submit() async {
    ///[formKey] is attached to the key defined in the Form.
    ///This function return a bool regards to the validator conditions.
    if(!formKey.currentState.validate()) return;
      
    ///[To fire the onSaved] that have the TextFormFields, this method should be called:
    formKey.currentState.save(); 

    //Disabled the button while the request is being processed to avoid multiple wrong request
    setState((){ _saving = true; });

    if(photo != null){
      scaffoldKey.currentState.showSnackBar(
        mySnackbar('Loading, please wait', Icons.done, Colors.blueGrey, 5000)
      );
      product.photoUrl = await api.uploadImage(photo);
    }

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
    Timer(Duration(milliseconds: 1500), () => Navigator.pop(context));
  }

  void _selectImage(ImageSource source) async {
    ///[pickImage return the path of the photo] and will be 
    ///available in photo.path
    photo = await ImagePicker.pickImage(
      source: source
    );

    if(photo != null){
      ///[render a new photo selected] and replace the older that come from firebase. 
      product.photoUrl = null;
    }
    setState(() {
      _renderPhoto();
    });
  }

  Widget _renderPhoto() {

    if(product.photoUrl != null){
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(product.photoUrl),
          height: 300.0,
          fit: BoxFit.contain,
        )
      );
    } else{
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image(
        image: AssetImage( photo?.path ?? 'assets/no-photo.png'),
        height: 300.0,
        fit: BoxFit.cover,
        ),
      );
    }
  }
}