import 'package:flutter/material.dart';
import 'package:user_preferences/src/models/product_model.dart';
import 'package:user_preferences/src/providers/products_provider.dart';
import 'package:user_preferences/src/share_prefs/preferences.dart';
import 'package:user_preferences/src/widgets/drawer.dart';

class ProductPage extends StatelessWidget {

  final prefs = new Preferences();
  final product = new ProductModel();
  final api = new ProductsProvider();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My products'),
      ),
      drawer: drawerWidget(context),
      floatingActionButton: _floatButton(context, prefs),
      body: _productsList(),
    );
  }

  Widget  _floatButton(BuildContext context,Preferences prefs) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).backgroundColor,
      onPressed: (){
        Navigator.pushNamed(context, 'addProduct');
      },
    );
  }

  Widget _productsList() {
    return FutureBuilder(
      future: api.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            ///[How Render] each element of the data [list]
            itemBuilder: (context,i) => _renderProduct(snapshot.data[i], context)
          );
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _renderProduct(ProductModel product, BuildContext context){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (dismiss){
        print(dismiss);
      },
      child: ListTile(
        title: Text('${product.title} - ${product.value}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'addProduct'),
      ),
    );
  }
}
