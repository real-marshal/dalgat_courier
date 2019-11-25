import 'package:dalgat_courier/blocs/app_settings_bloc.dart';
import 'package:dalgat_courier/blocs/cart_bloc.dart';
import 'package:dalgat_courier/common/routes.dart';
import 'package:dalgat_courier/services/auth_service.dart';
import 'package:dalgat_courier/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/user_bloc.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dbService = DBService();

    return MultiProvider(
      providers: [
        Provider<DBService>(
          builder: (context) => dbService,
        ),
        Provider<AppSettingsBloc>(
          builder: (context) => AppSettingsBloc(),
          dispose: (context, value) => value.dispose(),
        ),
        Provider<UserBloc>(
          builder: (context) =>
              UserBloc(authService: new AuthService(), dbService: dbService),
          dispose: (context, value) => value.dispose(),
        ),
        Provider<CartBloc>(
          builder: (context) => CartBloc(),
          dispose: (context, value) => value.dispose(),
        )
      ],
      child: Consumer<AppSettingsBloc>(
        builder: (context, appSettingsBloc, child) => StreamBuilder(
          stream: appSettingsBloc.themeData,
          builder: (context, AsyncSnapshot<ThemeData> snapshot) => MaterialApp(
            title: 'ДалгатКурьер',
            theme: snapshot.data,
            initialRoute: '/',
            routes: routes,
          ),
        ),
      ),
    );
  }
}
