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
                child: url == null 
                ? const Image(
                  image: AssetImage("Assets/no-image.png"),
                  fit: BoxFit.cover,)
            
                : FadeInImage(
                  image: NetworkImage(url!),
                  placeholder: const AssetImage("Assets/jar-loading.gif"),
                  fit: BoxFit.cover,
              ),
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
}