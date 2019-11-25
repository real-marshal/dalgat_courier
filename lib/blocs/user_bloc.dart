import 'package:dalgat_courier/models/user.dart';
import 'package:dalgat_courier/services/auth_service.dart';
import 'package:dalgat_courier/services/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final AuthService _authService;
  final DBService _dbService;
  final BehaviorSubject<User> _userBS = BehaviorSubject();

  Stream<User> get user => _userBS.stream;

  UserBloc({authService, dbService})
      : this._authService = authService,
        this._dbService = dbService;

  Future<void> register(String email, String password) async {
    AuthResult authResult;
    try {
      authResult = await _authService.register(email, password);
    } catch (err) {
      rethrow;
    }

    var user = await _dbService.create<User>(
      User(
          id: authResult.user.uid,
          email: authResult.user.email,
          role: Role.buyer),
    );

    _userBS.add(user);
  }

  Future<void> signIn(String email, String password) async {
    var authResult;
    try {
      authResult = await _authService.signIn(email, password);
    } catch (err) {
      rethrow;
    }

    var user = await _dbService.findById<User>(id: authResult.user.uid);

    _userBS.add(user);
  }

  void signOut() {
    _authService.signOut();
    _userBS.add(User());
  }

  void dispose() {
    _userBS.close();
  }
}
