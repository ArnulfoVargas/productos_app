import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier{
  final String _baseUrl = "flutter-products-8eeea-default-rtdb.firebaseio.com";
  final List<Product> products = [];

  late Product selectedProduct;
  bool isLoading = false;
  bool isSaving = false;
  File? pictureFile;

  ProductService(){
    loadProducts();
  }

   Future<List<Product>> loadProducts() async{
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final req = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode( req.body );

    products.clear();
  
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

  void updateSelectedImagePath(String path){
    pictureFile = File.fromUri(Uri(path: path));
    selectedProduct.picture = path;

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (pictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse("https://api.cloudinary.com/v1_1/productos_app/image/upload?upload_preset=Flutter&api_key=544595475918752");

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath("file", pictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
    
    if(response.statusCode != 200 && response.statusCode != 201){
      return null;
    }

    final decodedDate = json.decode(response.body);

    return decodedDate["secure_url"];
  }
}