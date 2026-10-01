import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';

abstract class ProfileAdminDataSource {

  Future<Either<Fuiler, String>> updateProfile(
    String adminName,
    String adminPhone,
    String? adminImage,
  );
}