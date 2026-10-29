import 'package:flutter/material.dart';

import 'package:examen_movil/cart_detail/cart_detail_service.dart';
import 'package:examen_movil/carts/carts_screen.dart';
import 'package:examen_movil/carts/carts_service.dart';
import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/products/products_screen.dart';
import 'package:examen_movil/products/products_service.dart';

class HomeScreen extends StatefulWidget {
  final ProductsService productsService;
  final ProductByIdService productByIdService;
  final CartsService cartsService;
  final CartDetailService cartDetailService;

  const HomeScreen({
    super.key,
    required this.productsService,
    required this.productByIdService,
    required this.cartsService,
    required this.cartDetailService,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack conserva cada pestaña, así no se recarga al cambiar.
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ProductsScreen(
            productsService: widget.productsService,
            productByIdService: widget.productByIdService,
          ),
          CartsScreen(
            cartsService: widget.cartsService,
            cartDetailService: widget.cartDetailService,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Carritos',
          ),
        ],
      ),
    );
  }
}
