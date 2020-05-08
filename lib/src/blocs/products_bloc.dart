import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:user_preferences/src/models/product_model.dart';
import 'package:user_preferences/src/providers/products_provider.dart';

class ProductsBloc{

  final _productController = new BehaviorSubject<List<ProductModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _productsProvider = new ProductsProvider();

  Stream<List<ProductModel>> get productsStream => _productController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  void getProducts() async {
    final products = await _productsProvider.getProducts();
    _productController.sink.add(products);
  }

  void addProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productsProvider.createProduct(product);
    _loadingController.sink.add(false);
    this.getProducts();
  }

  Future<String> uploadPhoto(File photo) async {
    _loadingController.sink.add(true);
    final photoUrl = await _productsProvider.uploadImage(photo);
    _loadingController.sink.add(false);
    return photoUrl;
  }

  void editProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await _productsProvider.updateProduct(product);
    _loadingController.sink.add(false);
    this.getProducts();
  }

  void deleteProduct(String id) async {
    await _productsProvider.deleteProduct(id);
    this.getProducts();
  }

  dispose(){
    _productController?.close();
    _loadingController?.close();
  }
}