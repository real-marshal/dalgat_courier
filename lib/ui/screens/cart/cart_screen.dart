import 'package:dalgat_courier/blocs/cart_bloc.dart';
import 'package:dalgat_courier/models/cart.dart';
import 'package:dalgat_courier/models/cart_product.dart';
import 'package:dalgat_courier/ui/screens/products/product_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Provider.of<CartBloc>(context).cart,
        builder: (context, AsyncSnapshot<Cart> snapshot) => snapshot.hasData
            ? snapshot.data.numberOfProducts > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          height: 500,
                          child: ListView.builder(
                            itemCount: snapshot.data.numberOfProducts,
                            itemBuilder: (context, index) => _buildCartItem(
                                context, snapshot.data.products[index]),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text('Итого: ${snapshot.data.price}₽'),
                            ),
                          ],
                        ),
                        _buildCreateOrder(context),
                      ])
                : Center(
                    child: Text(
                      'В корзине отсутствуют товары',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                    ),
                  )
            : CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartProduct cartProduct) {
    return Dismissible(
      key: Key(cartProduct.product.id),
      onDismissed: (direction) {
        Provider.of<CartBloc>(context).removeProduct(cartProduct);

        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            behavior: SnackBarBehavior.floating,
            content: Text(
                'Товар ${cartProduct.product.title} был удален из корзины'),
          ),
        );
      },
      child: ListTile(
        leading: ProductImage(cartProduct.product),
        title: Text(cartProduct.product.title),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('${cartProduct.product.price}₽'),
            Text(
                '${cartProduct.number}шт × ${cartProduct.product.price}₽ = ${cartProduct.price}₽'),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateOrder(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            'Оформление заказа',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
