import 'package:dalgat_courier/ui/common/app_drawer.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Пользователи'),
      ),
    );
  }
}
