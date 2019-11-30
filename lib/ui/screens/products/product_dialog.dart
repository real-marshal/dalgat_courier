import 'package:dalgat_courier/models/product.dart';
import 'package:dalgat_courier/ui/screens/products/product_add_controls.dart';
import 'package:dalgat_courier/ui/screens/products/product_image.dart';
import 'package:flutter/material.dart';

class ProductDialog extends StatelessWidget {
  final Product product;

  ProductDialog(this.product);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: 300,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                product.title,
                style: TextStyle(color: Colors.grey[850], fontSize: 20),
              ),
            ),
            Expanded(
              child: ProductImage(product),
            ),
            ProductAddControls(product),
          ],
        ),
      ),
    );
  }
}
