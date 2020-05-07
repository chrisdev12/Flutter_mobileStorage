import 'dart:convert';

import 'package:user_preferences/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsProvider{

  final String _url = 'https://flutterproducts-ec3b8.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async{

    final reqUrl = '$_url/products.json';
    final res = await http.post(reqUrl, body: productModelToJson(product));
    return json.decode(res.body);
  }

  Future<List<ProductModel>> getProducts() async{

    final reqUrl = '$_url/products.json';
    final res = await http.get(reqUrl);
    final Map<String,dynamic> resDecoded = json.decode(res.body);
    
    if(resDecoded == null) return [];

    final List<ProductModel> products = new List();
    resDecoded.forEach((id,value){
      final prodTemp = ProductModel.fromJson(value);
      prodTemp.id = id;
      products.add(prodTemp);
    });

    return products;
  }
}