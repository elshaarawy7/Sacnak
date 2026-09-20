import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/profile_dmain/data/datasource/data_sourcse_profile_admain.dart';
import 'package:sacny/feat/admin/profile_dmain/data/repo/profile_admain_repo.dart';

class ProfileAdmainRepoImple implements ProfileAdmainRepo {
  final ProfileAdmainDataSource profileAdmainDataSource;

  ProfileAdmainRepoImple({required this.profileAdmainDataSource});

  @override
  Future<Either<Fuiler, String>> updateProfile(String name, String phone, String? imagePath) {
    return profileAdmainDataSource.updateProfile(name, phone, imagePath); 
    
  }

 

}