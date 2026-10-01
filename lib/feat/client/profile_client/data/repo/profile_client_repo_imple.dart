import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/client/profile_client/data/datasource/data_sourcse_profile_client.dart';
import 'package:sacny/feat/client/profile_client/data/repo/profile_admain_repo.dart';

class ProfileClientRepoImple implements ProfileClientRepo {
  final ProfileClientDataSource profileClientDataSource;

  ProfileClientRepoImple({required this.profileClientDataSource});

  @override
  Future<Either<Fuiler, String>> updateProfile(String name, String phone, String? imagePath) {
    return profileClientDataSource.updateProfile(name, phone, imagePath); 
    
  }

 

}