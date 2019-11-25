import 'package:dalgat_courier/models/product.dart';

class CartProduct {
  /// Product
  final Product _product;

  /// Number of products
  int _number = 0;

  CartProduct(this._product);

  Product get product => _product;
  int get number => _number;

  void add([int number = 1]) {
    _number += number;
  }

  void remove([int number = 1]) {
    _number += number;
  }
}
