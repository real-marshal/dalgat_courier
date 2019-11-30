import 'package:dalgat_courier/models/product.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final Product product;

  ProductImage(this.product);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: product.image != null
          ? Image.network(
              product.image,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
            )
          : Image.asset('assets/no_product.jpg'),
    );
  }
}
