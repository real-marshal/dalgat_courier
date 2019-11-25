import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> register(String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult;
    } catch (err) {
      throw new AuthException(
          registerErrorsMap[err.code] ?? 'неизвестная ошибка');
    }
  }

  Future<AuthResult> signIn(String email, String password) async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return authResult;
    } catch (err) {
      throw new AuthException(
          signInErrorsMap[err.code] ?? 'неизвестная ошибка');
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}

class AuthException {
  final String message;

  AuthException(this.message);
}

const registerErrorsMap = {
  'ERROR_WEAK_PASSWORD': 'слишком слабый пароль',
  'ERROR_INVALID_EMAIL': 'email имеет неверный формат',
  'ERROR_EMAIL_ALREADY_IN_USE': 'данный email уже зарегистрирован',
};

const signInErrorsMap = {
  'ERROR_INVALID_EMAIL': 'неверный email',
  'ERROR_WRONG_PASSWORD': 'неверный пароль',
  'ERROR_USER_NOT_FOUND': 'пользователь с таким email не найден',
  'ERROR_USER_DISABLED': 'пользователь забанен',
  'ERROR_TOO_MANY_REQUESTS': 'слишком много запросов',
  'ERROR_OPERATION_NOT_ALLOWED': 'операция недоступна'
};
