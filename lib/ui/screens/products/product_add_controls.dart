import 'package:dalgat_courier/blocs/cart_bloc.dart';
import 'package:dalgat_courier/models/product.dart';
import 'package:dalgat_courier/ui/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAddControls extends StatefulWidget {
  final Product product;
  ProductAddControls(this.product);

  @override
  State<StatefulWidget> createState() => ProductAddControlsState();
}

class ProductAddControlsState extends State<ProductAddControls> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AppButton(
            text: '-',
            buttonType: ButtonType.secondary,
            shape: CircleBorder(),
            onPressed: () => number > 1 ? setState(() => number--) : null,
          ),
          Text('$number'),
          AppButton(
            text: '+',
            buttonType: ButtonType.secondary,
            shape: CircleBorder(),
            onPressed: () => setState(() => number++),
          ),
          AppButton(
            text: 'В корзину',
            onPressed: () {
              Provider.of<CartBloc>(context).addProduct(widget.product, number);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
