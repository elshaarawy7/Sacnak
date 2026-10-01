import 'package:sacny/feat/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.password,
  });  

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );

    Map<String, dynamic> toJson() => {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
}