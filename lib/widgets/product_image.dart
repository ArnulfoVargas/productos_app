import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? url;

  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
        child: Container(
          width: double.infinity,
          height: 450,
          decoration: _productImageDecoration(),

          child: Opacity(
            opacity: .9,
            child: ClipRRect(
                borderRadius: _productImageRadius(),
                child: _getImage(url),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _productImageDecoration() => BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black,
        Colors.black,
        Colors.white
      ]
    ),
    color: Colors.white,
    borderRadius: _productImageRadius(),
    boxShadow: const [BoxShadow( color: Colors.black26, offset: Offset(5,5), blurRadius: 5)],
  );

  BorderRadius _productImageRadius() => const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30));

  Widget _getImage(String? path){
    if (path == null){
      return const Image(
        image: AssetImage("Assets/no-image.png"),
        fit: BoxFit.cover,);
    }

    else{
      if (path.startsWith("http")){
        return FadeInImage(
            placeholder: const AssetImage("Assets/jar-loading.gif"),
            image: NetworkImage(path),
            fit: BoxFit.cover,);
      }else{
        return Image.file(File(path),
                          fit: BoxFit.cover,);
      }
    }
  }

}