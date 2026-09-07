import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/auth/data/datasourse/datasourse_auth.dart';
import 'package:sacny/feat/auth/data/model/user_model.dart';

class DatasourseAuthImple implements DataSourceAuth{ 
  final  FirebaseAuth firebaseAuth; 

  DatasourseAuthImple({required this.firebaseAuth});
  @override
  Future<Either<Fuiler, UserModel>> Login({required String email , required String password}) async {  

    try { 
      final credentials = await firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password , 
      );  

      return Right(UserModel(
        name: credentials.user?.displayName ?? 'User',
        email: credentials.user?.email ?? email,
        phone: credentials.user?.phoneNumber ?? '',
        password: password,
      )); 
        
      
    } catch (e) {
      return Left(ServerFuiler(e.toString()));
    }
  }

  @override
  Future<Either<Fuiler, UserModel>> Register({required String email, required String password, required String phone, required String name})async { 
    
    try { 
      final credentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password , 
      );  

      return Right(UserModel(
        name: credentials.user?.displayName ?? 'User',
        email: credentials.user?.email ?? email,
        phone: credentials.user?.phoneNumber ?? '',
        password: password,
      )); 
        
      
    } catch (e) {
      return Left(ServerFuiler(e.toString()));
    } 
  }
   
  
}