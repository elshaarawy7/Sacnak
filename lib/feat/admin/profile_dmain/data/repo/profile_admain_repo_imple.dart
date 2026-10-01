import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/profile_dmain/data/datasource/data_sourcse_profile_admain.dart';
import 'package:sacny/feat/admin/profile_dmain/data/repo/profile_admain_repo.dart';

class ProfileAdminRepoImple implements ProfileAdminRepo {
  final ProfileAdminDataSource profileAdminDataSource;

  ProfileAdminRepoImple({required this.profileAdminDataSource});

  @override
  Future<Either<Fuiler, String>> updateProfile(
    String adminName,
    String adminPhone,
    String? adminImage,
  ) {
    return profileAdminDataSource.updateProfile(adminName, adminPhone, adminImage);
  }

 

}