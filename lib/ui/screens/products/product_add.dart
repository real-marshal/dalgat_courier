import 'package:dalgat_courier/blocs/cart_bloc.dart';
import 'package:dalgat_courier/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAdd extends StatefulWidget {
  final Product product;
  ProductAdd(this.product);

  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State<ProductAdd> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton(
          child: Text('-'),
          onPressed: () => number > 1 ? setState(() => number--) : null,
        ),
        Text('$number'),
        FlatButton(
          child: Text('+'),
          onPressed: () => setState(() => number++),
        ),
        RaisedButton(
          child: Text(
            'В корзину',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Provider.of<CartBloc>(context).addProduct(widget.product, number);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
