import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier{
  final String _baseUrl = "flutter-products-8eeea-default-rtdb.firebaseio.com";
  final List<Product> products = [];

  late Product selectedProduct;
  bool isLoading = false;
  bool isSaving = false;

  ProductService(){
    _loadProducts();
  }

   Future<List<Product>> _loadProducts() async{
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final req = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode( req.body );

   productsMap.forEach((key, value) { 
    final Product temp = Product.fromMap(value);
    temp.id = key;

    products.add(temp);
   });

    isLoading = false;
    notifyListeners();

   return products;
  } 

  Future saveOrCreateProducts(Product product) async {
    isSaving = true;
    notifyListeners();

    if(product.id == null){
      await _createProduct(product);
    }
    else{
      await _updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> _updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    await http.put(url, body: product.toJson());

    final index = products.indexWhere((Product element) => element.id == product.id);

    products[index] = product;

    return product.id!;
  }

  Future<String> _createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final post = await http.post(url, body: product.toJson());
    final decodedData = jsonDecode(post.body);
    product.id = decodedData['name'];

    products.add(product);

    return product.id!;
  }
}