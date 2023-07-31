import 'package:flutter/material.dart';
import 'package:productos_app/Themes/themes.dart';

class LoadingScreen extends StatelessWidget {
  static const String name = "loading_screen";
   
  const LoadingScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:const Center(
        child: CircularProgressIndicator(
          color: CustomTheme.primaryColor,
          strokeWidth: 5
        ),
      ),
      appBar: AppBar(title: const Text("Productos")),
    );
  }
}