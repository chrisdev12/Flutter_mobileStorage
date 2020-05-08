import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:user_preferences/src/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import 'package:user_preferences/src/share_prefs/preferences.dart';

class ProductsProvider{

  final String _url = 'https://flutterproducts-ec3b8.firebaseio.com';
  // final _prefs = new Preferences(); //Use token if is needed : '$_url/products.json?auth=${_prefs.token}';

  Future<String> createProduct(ProductModel product) async{

    final reqUrl = '$_url/products.json';
    final res = await http.post(reqUrl, body: productModelToJson(product));
    final resDecoded =  json.decode(res.body); //Firebase res return a Map.
    return resDecoded['name'];
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

  Future deleteProduct(String id) async{

    final reqUrl = '$_url/products/$id.json';
    final res = await http.delete(reqUrl);
    
    return json.decode(res.body);
  }

  Future updateProduct(ProductModel product) async{

    final reqUrl = '$_url/products/${product.id}.json';
    final res = await http.put(reqUrl,
      body: productModelToJson(product) 
    );
    
    return json.decode(res.body);
  }

  Future<String> uploadImage(File image) async{

    final mimeType = mime(image.path).split('/');
    final reqUrl = Uri.parse('https://api.cloudinary.com/v1_1/dircdfylu/image/upload?upload_preset=caqjqxxc');
    // final reqUrl = '$_url/products/${product.id}.json';
    final reqImage =  http.MultipartRequest( 'POST', reqUrl);
    
    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0],mimeType[1])
    );

    reqImage.files.add(file);
    final streamRes = await reqImage.send();
    final res = await http.Response.fromStream(streamRes);

    if(res.statusCode != 200 && res.statusCode != 201){
      print('Somethings worng ${json.decode(res.body)}');
      return null;
    }
    return json.decode(res.body)['secure_url'];
  }
}