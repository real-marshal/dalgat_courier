import 'package:dalgat_courier/ui/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:dalgat_courier/ui/screens/auth/auth_screen.dart';
import 'package:dalgat_courier/ui/screens/products/products_screen.dart';

final routes = <String, WidgetBuilder>{
  '/': (context) => ProductsScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(),
  AuthScreen.routeName: (context) => AuthScreen(),
  CartScreen.routeName: (context) => CartScreen()
};
