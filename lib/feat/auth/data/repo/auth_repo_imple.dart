import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/auth/data/datasourse/datasourse_auth.dart';
import 'package:sacny/feat/auth/data/model/user_model.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo.dart';

class AuthRepoImple implements AuthRepo {
  final DataSourceAuth dataSourceAuth;

  AuthRepoImple({required this.dataSourceAuth});

  @override
  Future<Either<Fuiler, UserModel>> Login({
    required String email,
    required String password,
  }) async {
    return dataSourceAuth.Login(email: email, password: password);
  }

  @override
  Future<Either<Fuiler, UserModel>> Register({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    return dataSourceAuth.Register(
      email: email,
      password: password,
      phone: phone,
      name: name,
    );
  }

  @override
  Future<Either<Fuiler, UserModel>> signInWithGoogle() {
    return dataSourceAuth.signInWithGoogle();
  }
}
