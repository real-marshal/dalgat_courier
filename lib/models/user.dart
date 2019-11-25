import 'package:dalgat_courier/services/db_service.dart';
import 'package:enum_to_string/enum_to_string.dart';

class User extends DBModel {
  String get collectionName => 'users';

  final String id;
  final String email;
  final Role role;

  User({this.id, this.email, this.role});

  @override
  User fromMap(Map<String, dynamic> map) {
    return User(
        id: map[id],
        email: map['email'],
        role: EnumToString.fromString(Role.values, map['role']));
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': EnumToString.parse(role),
    };
  }
}

enum Role {
  admin,
  courier,
  buyer,
}
