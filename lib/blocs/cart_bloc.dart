import 'package:dalgat_courier/models/cart.dart';
import 'package:dalgat_courier/models/cart_product.dart';
import 'package:dalgat_courier/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final _cart = Cart();

  final _cartBS = BehaviorSubject<Cart>();
  final _productsCountBS = BehaviorSubject<int>.seeded(0);

  Stream<Cart> get cart => _cartBS.stream;
  Stream<int> get productCount => _productsCountBS.stream;

  CartBloc() {
    _cartBS.listen((newCart) => _productsCountBS.add(newCart.numberOfProducts));
  }

  void addProduct(Product product, int number) {
    _cart.addProduct(product, number);
    _cartBS.add(_cart);
  }

  void removeProduct(CartProduct product) {
    _cart.removeProduct(product);
    _cartBS.add(_cart);
  }

  void dispose() {
    _cartBS.close();
    _productsCountBS.close();
  }
}
