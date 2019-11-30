import 'package:dalgat_courier/models/product.dart';

class CartProduct {
  final Product _product;

  int _number = 0;

  CartProduct(this._product);

  Product get product => _product;
  int get number => _number;
  int get price => _number * _product.price;

  void add([int number = 1]) {
    _number += number;
  }

  void remove([int number = 1]) {
    _number += number;
  }
}
