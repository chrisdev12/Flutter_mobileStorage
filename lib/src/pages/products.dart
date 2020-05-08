import 'package:flutter/material.dart';
import 'package:user_preferences/src/blocs/products_bloc.dart';
import 'package:user_preferences/src/blocs/provider.dart';
import 'package:user_preferences/src/models/product_model.dart';
import 'package:user_preferences/src/widgets/drawer.dart';
import 'package:user_preferences/src/widgets/snackBar.dart';

class ProductPage extends StatelessWidget {

  final product = new ProductModel();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ///[Provider.products] works same that .of in loginForm. search the provider
    /// in the widgets Three and do an init of the productsBloc class
    final productsBloc = Provider.products(context);
    productsBloc.getProducts();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('My products'),
        backgroundColor: Theme.of(context).backgroundColor
      ),
      body: _productsList(productsBloc),
      drawer: drawerWidget(context),
      floatingActionButton: _floatButton(context),
    );
  }

  Widget  _floatButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).backgroundColor,
      onPressed: (){
        Navigator.pushNamed(context, 'addProduct');
      },
    );
  }

  Widget _productsList(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
            ///[How Render] each element of the data [list]
            itemBuilder: (context,i) => _renderProduct(snapshot.data[i], context, productsBloc)
          );
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _renderProduct(ProductModel product, BuildContext context,ProductsBloc productsBloc){

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        scaffoldKey.currentState.showSnackBar(
          mySnackbar('Product deleted', Icons.delete_forever, Colors.redAccent, 1500)
        );
        return productsBloc.deleteProduct(product.id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        child: Column(
          children: <Widget>[
            (product.photoUrl == null) 
              ? _assetImage()
              :  _networkImage(product.photoUrl),
            ListTile(
              title: Text('${product.title} - ${product.value}'),
              trailing: Text('edit'),
              subtitle: Text(product.id),
              onTap: () => Navigator.pushNamed(context, 'addProduct', arguments: product),
            ),
          ],
        ),
      )
    );
  }

  Widget _assetImage(){
    return Image(
      image: AssetImage('assets/no-photo.png'),
      height: 300.0,
      fit: BoxFit.cover,
    );
  }

  Widget _networkImage(String url){
    return  FadeInImage(
      placeholder: AssetImage('assets/loading.gif'),
      image: NetworkImage(url),
      height: 300.0,
      fit: BoxFit.cover,
    );
  }
}



