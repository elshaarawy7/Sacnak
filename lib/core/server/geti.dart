import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sacny/core/server/firebase_auth_services.dart';
import 'package:sacny/feat/auth/data/datasourse/datasourse_auth.dart';
import 'package:sacny/feat/auth/data/datasourse/datasourse_authimple.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo_imple.dart';
import 'package:sacny/feat/auth/presentation/manager/gooole/google_cubit.dart';
import 'package:sacny/feat/auth/presentation/manager/login/login_cubit.dart';
import 'package:sacny/feat/auth/presentation/manager/regester/regester_cubit.dart';

final getit = GetIt.instance;  

void getsetUp() { 
  getit.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getit.registerLazySingleton<FirebaseAuthServices>(
    () => FirebaseAuthServices(firebaseAuth: getit()),
  );
  getit.registerLazySingleton<DataSourceAuth>(
    () => DatasourseAuthImple(firebaseAuthServices: getit()),
  );
  getit.registerLazySingleton<AuthRepo>(() => AuthRepoImple(dataSourceAuth: getit()));

  getit.registerFactory(() => LoginCubit(getit()));  
  getit.registerFactory(() => RegesterCubit(getit()));   
  getit.registerFactory(() => GoogleCubit( getit()));
} 
