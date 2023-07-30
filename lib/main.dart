import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:productos_app/Themes/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos App',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.name,
      routes: {
        LoginScreen.name :(context) => const LoginScreen(),
        HomeScreen.name :(context) => const HomeScreen(),
        ProductScreen.name :((context) => const ProductScreen())
      },
      theme: CustomTheme.mainTheme,
    );
  }
}