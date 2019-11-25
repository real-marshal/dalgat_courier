import 'package:dalgat_courier/blocs/user_bloc.dart';
import 'package:dalgat_courier/models/user.dart';
import 'package:dalgat_courier/ui/screens/auth/auth_screen.dart';
import 'package:dalgat_courier/ui/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: DrawerHeader(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Center(
                child: StreamBuilder(
                  stream: Provider.of<UserBloc>(context).user,
                  builder: (context, AsyncSnapshot<User> snapshot) => Row(
                    children: <Widget>[
                      if (!snapshot.hasData || snapshot.data.id == null)
                        FlatButton(
                          child: Text(
                            'Войти / Создать аккаунт',
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, AuthScreen.routeName),
                        ),
                      if (snapshot.hasData && snapshot.data.id != null)
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 230,
                              child: Text(
                                '${snapshot.data.email}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.exit_to_app),
                              onPressed: () =>
                                  Provider.of<UserBloc>(context).signOut(),
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Товары'),
            leading: Icon(Icons.shopping_basket),
            onTap: () => Navigator.pushReplacementNamed(
                context, ProductsScreen.routeName),
          )
        ],
      ),
    );
  }
}
