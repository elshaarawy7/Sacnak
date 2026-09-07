import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/core/server/firebase_auth_services.dart';
import 'package:sacny/feat/auth/data/datasourse/datasourse_auth.dart';
import 'package:sacny/feat/auth/data/model/user_model.dart';

class DatasourseAuthImple implements DataSourceAuth {
  DatasourseAuthImple({required FirebaseAuthServices firebaseAuthServices})
      : _authServices = firebaseAuthServices;

  final FirebaseAuthServices _authServices;

  @override
  Future<Either<Fuiler, UserModel>> Login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(
        UserModel(
          name: user.displayName ?? 'User',
          email: user.email ?? email,
          phone: user.phoneNumber ?? '',
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFuiler(e.toString()));
    }
  }

  @override
  Future<Either<Fuiler, UserModel>> Register({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    try {
      final user = await _authServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user.updateDisplayName(name.trim());

      return Right(
        UserModel(
          name: user.displayName ?? name,
          email: user.email ?? email,
          phone: user.phoneNumber ?? phone,
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFuiler(e.toString()));
    }
  }

  @override
  Future<Either<Fuiler, UserModel>> signInWithGoogle() async {
    try {
      final user = await _authServices.signInWithGoogle();

      return Right(
        UserModel(
          name: user.displayName ?? 'User',
          email: user.email ?? '',
          phone: user.phoneNumber ?? '',
          password: '',
        ),
      );
    } catch (e) {
      return Left(ServerFuiler(e.toString()));
    }
  }
}
