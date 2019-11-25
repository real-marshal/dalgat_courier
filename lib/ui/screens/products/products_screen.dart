import 'package:dalgat_courier/blocs/cart_bloc.dart';
import 'package:dalgat_courier/models/product.dart';
import 'package:dalgat_courier/services/db_service.dart';
import 'package:dalgat_courier/ui/screens/cart/cart_screen.dart';
import 'package:dalgat_courier/ui/screens/products/product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_drawer.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Provider.of<CartBloc>(context).productCount,
        builder: (context, AsyncSnapshot<int> snapshot) => Scaffold(
              appBar: AppBar(
                title: Text('Выбираем нямки'),
                actions: <Widget>[
                  if (snapshot.data != 0)
                    Stack(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () => Navigator.pushNamed(
                              context, CartScreen.routeName),
                        ),
                        Positioned(
                            top: 3.0,
                            right: 4.0,
                            child: Center(
                              child: Text(
                                snapshot.data.toString(),
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )
                ],
              ),
              drawer: AppDrawer(),
              body: Consumer<DBService>(
                builder: (context, dbService, child) => StreamBuilder(
                  stream: dbService.read<Product>(),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200),
                      padding: EdgeInsets.all(5),
                      itemBuilder: (context, index) =>
                          index < snapshot.data.length
                              ? _buildProduct(context, snapshot.data[index])
                              : null,
                    );
                  },
                ),
              ),
            ));
  }

  Widget _buildProduct(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () => showDialog(
          context: context, builder: (context) => ProductDialog(product)),
      child: Container(
        margin: EdgeInsets.all(5),
        child: Material(
          elevation: 3,
          child: GridTile(
            key: Key(product.id),
            header: GridTileBar(
              title: Text(
                '${product.title}',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ),
            footer: GridTileBar(
              title: Text(
                product.price != null ? '${product.price}₽' : 'Цена не указана',
                style: TextStyle(color: Colors.grey[850]),
              ),
            ),
            child: Container(
              child: product.image != null
                  ? Image.network(
                      product.image,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator()),
                    )
                  : Image.asset('assets/no_product.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
