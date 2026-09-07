import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sacny/feat/auth/data/datasourse/datasourse_auth.dart';
import 'package:sacny/feat/auth/data/datasourse/datasourse_authimple.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo_imple.dart';
import 'package:sacny/feat/auth/presentation/manager/login/login_cubit.dart';
import 'package:sacny/feat/auth/presentation/manager/regester/regester_cubit.dart';

final getit = GetIt.instance;  

void getsetUp() { 
  getit.registerLazySingleton<AuthRepo>(() => AuthRepoImple(dataSourceAuth: getit()));
  getit.registerLazySingleton<DataSourceAuth>(() => DatasourseAuthImple(firebaseAuth: getit()));   
  getit.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);  

  getit.registerFactory(() => LoginCubit(getit()));  
  getit.registerFactory(() => RegesterCubit(getit()));  
} 
