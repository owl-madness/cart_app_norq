import 'package:cart_app_norq/authentication/controller/auth_provider.dart';
import 'package:cart_app_norq/authentication/screen/signin_screen.dart';
import 'package:cart_app_norq/cart/controller/products_provider.dart';
import 'package:cart_app_norq/home/controller/home_provider.dart';
import 'package:cart_app_norq/home/screen/home_screen.dart';
import 'package:cart_app_norq/utilities/sqflite_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DatabaseHelper dbHelper = DatabaseHelper.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.database;

  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
