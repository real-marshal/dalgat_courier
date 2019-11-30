import 'package:dalgat_courier/models/cart_product.dart';
import 'package:dalgat_courier/models/product.dart';

class Cart {
  List<CartProduct> _products = [];

  List<CartProduct> get products => _products;
  int get numberOfProducts => _products.length;
  int get price => _products.fold(0, (sum, product) => sum + product.price);

  void addProduct(Product product, int number) {
    final cartProduct = _products.firstWhere(
        (cartProduct) => cartProduct.product.id == product.id, orElse: () {
      var cartProduct = CartProduct(product);
      _products.add(cartProduct);
      return cartProduct;
    });
    cartProduct.add(number);
  }

  void removeProduct(CartProduct product) {
    _products.remove(product);
  }
}
