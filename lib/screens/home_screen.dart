import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  
  static const String name = "Home";

  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    final ProductService productService = Provider.of<ProductService>(context);

    if (productService.isLoading) return const LoadingScreen();

    final List<Product> products = productService.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),

      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) =>  GestureDetector(
          onTap: (() {
            Navigator.pushNamed(context, ProductScreen.name);
            productService.selectedProduct = products[index].copy();
          }),
          child: ProductCard(product: products[index],)
          ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          productService.selectedProduct = Product(available: false, name:"", price: 0);

          Navigator.pushNamed(context, ProductScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}