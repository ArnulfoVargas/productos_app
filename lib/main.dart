import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:productos_app/Themes/themes.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: ((context) => ProductService()),),
        ChangeNotifierProvider(create: ((context) => AuthService()),),

        ],
      child: const MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos App',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: NotificationService.messengerKey,
      initialRoute: CheckAuthScreen.name,
      routes: {
        LoginScreen.name    :(context) => const LoginScreen(),
        CheckAuthScreen.name:(context) => const CheckAuthScreen(),
        RegisterScreen.name :(context) => const RegisterScreen(),
        HomeScreen.name     :(context) => const HomeScreen(),
        ProductScreen.name  :(context) => const ProductScreen(),
        LoadingScreen.name  :(context) => const LoadingScreen()
      },
      theme: CustomTheme.mainTheme,
    );
  }
}