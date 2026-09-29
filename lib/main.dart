import 'package:flutter/material.dart';

import 'screens/products_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda Examen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ProductsScreen(),
    );
  }
}
