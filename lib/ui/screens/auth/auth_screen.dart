import 'package:dalgat_courier/blocs/user_bloc.dart';
import 'package:dalgat_courier/services/auth_service.dart';
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

  void _register(UserBloc userBloc) async {
    try {
      if (email.isEmpty) throw AuthException('email пуст');
      if (password.isEmpty) throw AuthException('пароль пуст');

      setState(() => isLoading = true);
      await userBloc.register(email, password);
      Navigator.pop(context);
    } catch (err) {
      setState(() {
        error = 'Ошибка регистрации: ${err.message}';
        isLoading = false;
      });
    }
  }

  void _signIn(UserBloc userBloc) async {
    try {
      if (email.isEmpty) throw AuthException('email пуст');
      if (password.isEmpty) throw AuthException('пароль пуст');

      setState(() => isLoading = true);
      await userBloc.signIn(email, password);
      Navigator.pop(context);
    } on AuthException catch (err) {
      setState(() {
        error = 'Ошибка входа: ${err.message}';
        isLoading = false;
      });
    }
  }

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
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        style: TextStyle(color: Theme.of(context).accentColor),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white54),
                          fillColor: Colors.black54,
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                        onChanged: (value) => setState(() => email = value),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Theme.of(context).accentColor),
                        decoration: InputDecoration(
                          hintText: 'Пароль',
                          hintStyle: TextStyle(color: Colors.white54),
                          fillColor: Colors.black54,
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                        onChanged: (value) => setState(() => password = value),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: FlatButton(
                              color: Colors.teal,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(25.0)),
                              child: Text(
                                'Войти в аккаунт',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                              onPressed: () => _signIn(userBloc),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: FlatButton(
                              color: Colors.teal,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(25.0)),
                              child: Text(
                                'Создать',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                              onPressed: () => _register(userBloc),
                            ),
                          ),
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
