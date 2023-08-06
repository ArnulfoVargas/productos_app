import 'package:flutter/material.dart';
import 'package:productos_app/Themes/themes.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 30),
        height: 400,
        width: 300,
        decoration: _cardStyle(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children:  [
            _BackgroundImage(url: product.picture,),

            _ProductDetails(name: product.name, id: product.id!,),

            _PriceBox(price: product.price,),

            if (!product.available)
              const _Unavailable()
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardStyle() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(blurRadius: 5, 
                    color: Colors.black26,
                    offset: Offset(5, 5))
        ],
        color: Colors.white,
      );
  }
}

class _Unavailable extends StatelessWidget {
  
  const _Unavailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        height: 70,
        width: 120,
        decoration: _availableDecoration(),
        child: const FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("No disponible", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
          ),
        ),
      )
    );
  }

  BoxDecoration _availableDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
    color: CustomTheme.secondaryColor,
  );
}

class _PriceBox extends StatelessWidget {

  final double price;

  const _PriceBox({
    Key? key, required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: 100,
          height: 70,
          decoration: _priceDecoration(),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text("\$$price", textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
            ),
          ),
      ),
    );
  }

  BoxDecoration _priceDecoration() {
    return const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
            color: CustomTheme.primaryColor,
          );
  }
}

class _ProductDetails extends StatelessWidget {
  final String name;
  final String id;

  const _ProductDetails({
    Key? key, required this.name, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: double.infinity,
        height: 70,
        decoration: _detailsDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, 
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                  maxLines: 1, overflow: TextOverflow.ellipsis,),

            Text(id, 
                  style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 20),
                  maxLines: 1, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }

  BoxDecoration _detailsDecoration() =>  const BoxDecoration(
    color: CustomTheme.primaryColor,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topRight: Radius.circular(30))
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage({
    Key? key, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null

          ? const Image(
            image: AssetImage("Assets/no-image.png"),
            fit: BoxFit.cover,
            )

          :  FadeInImage(
            image: NetworkImage(url!),
            placeholder: const AssetImage("Assets/jar-loading.gif"),
            fit: BoxFit.cover,
        ),
      ),
    );
  }
}