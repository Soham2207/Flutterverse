import 'package:flutter/material.dart';
import 'package:flutterverse/cart_provider.dart';
import 'package:flutterverse/home_screen.dart';
import 'package:provider/provider.dart';

import 'item_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Shopping Cart',
        home: HomeScreen(),
      ),
    );
  }
}
