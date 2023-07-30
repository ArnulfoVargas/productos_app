import 'package:flutter/material.dart';
import 'package:productos_app/Themes/themes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
          children: const [
            _BackgroundImage(),

            _ProductDetails(),

            _PriceBox(),

            _Avaibility()
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardStyle() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(blurRadius: 10, 
                    color: Colors.black26,
                    offset: Offset(10, 10))
        ],
        color: Colors.white,
      );
  }
}

class _Avaibility extends StatelessWidget {
  const _Avaibility({
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
  const _PriceBox({
    Key? key,
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
          child: const FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text("\$104.99", textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
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
  const _ProductDetails({
    Key? key,
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
          children: const [
            Text("Disco Duro G", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                  maxLines: 1, overflow: TextOverflow.ellipsis,),

            Text("ID producto", 
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.normal, fontSize: 20),
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
  const _BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 400,
        child: const FadeInImage(
            image: NetworkImage("https://via.placeholder.com/400x300/fff"),
            placeholder: AssetImage("Assets/jar-loading.gif"),
            fit: BoxFit.cover,
        ),
      ),
    );
  }
}