import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';

abstract class ProfileAdmainDataSource {

  Future<Either<Fuiler, String>> updateProfile(
    String name,
    String phone,
    String? imagePath,
  );
}