import 'package:dalgat_courier/blocs/user_bloc.dart';
import 'package:dalgat_courier/services/auth_service.dart';
import 'package:dalgat_courier/ui/common/app_button.dart';
import 'package:dalgat_courier/ui/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  void _auth(UserBloc userBloc, bool isRegister) async {
    try {
      if (email.isEmpty) throw AuthException('email пуст');
      if (password.isEmpty) throw AuthException('пароль пуст');

      setState(() => isLoading = true);

      isRegister
          ? await userBloc.register(email, password)
          : await userBloc.signIn(email, password);

      Navigator.pop(context);
    } catch (err) {
      setState(() {
        error =
            'Ошибка ${isRegister ? 'регистрации' : 'входа'}: ${err.message}';
        isLoading = false;
      });
    }
  }

  void _register(UserBloc userBloc) async => _auth(userBloc, true);

  void _signIn(UserBloc userBloc) async => _auth(userBloc, false);

  @override
  Widget build(BuildContext context) {
    var userBloc = Provider.of<UserBloc>(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 50, 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Material(
              type: MaterialType.transparency,
              child: Form(
                child: Column(
                  children: <Widget>[
                    AppTextField(
                      hintText: 'Email',
                      onChanged: (value) => setState(() => email = value),
                    ),
                    AppTextField(
                      hintText: 'Пароль',
                      onChanged: (value) => setState(() => password = value),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AppButton('Войти в аккаунт',
                              onPressed: () => _signIn(userBloc)),
                          AppButton('Создать',
                              onPressed: () => _register(userBloc)),
                        ],
                      ),
                    ),
                    if (error != null)
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      ),
                    if (isLoading) CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
