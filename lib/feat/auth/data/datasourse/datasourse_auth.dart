import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/auth/data/model/user_model.dart';

abstract class DataSourceAuth { 

  Future<Either<Fuiler, UserModel>> Login({required String email, required String password}) ; 
  Future<Either<Fuiler, UserModel>> Register({required String email, required String password,required String phone,required String name}) ; 
  
}