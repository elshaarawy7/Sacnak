import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sacny/core/server/cloudinary_service.dart';
import 'package:sacny/core/server/firebase_auth_services.dart';
import 'package:sacny/feat/admin/add_drug/data/datasourcse/property_data_source.dart';
import 'package:sacny/feat/admin/add_drug/data/datasourcse/property_data_source_imple.dart';
import 'package:sacny/feat/admin/add_drug/data/repo/property_repository.dart';
import 'package:sacny/feat/admin/add_drug/data/repo/property_repository_imple.dart';
import 'package:sacny/feat/admin/add_drug/domain/usercase/add_property_usecase.dart';
import 'package:sacny/feat/admin/add_drug/presentation/cubit/propetry_cubit.dart';
import 'package:sacny/feat/admin/home_admain/data/datasourse/cart_home_admin_datasourse.dart';
import 'package:sacny/feat/admin/home_admain/data/datasourse/cart_home_admin_datasourse_imple.dart';
import 'package:sacny/feat/admin/home_admain/data/repo/cart_home_admin_repo.dart';
import 'package:sacny/feat/admin/home_admain/data/repo/cart_home_admin_repo_imple.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_cubit.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/cubit/profile_admain_cubit.dart';
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
  getit.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getit.registerLazySingleton<CloudinaryService>(() => CloudinaryService());
  getit.registerLazySingleton<FirebaseAuthServices>(
    () => FirebaseAuthServices(firebaseAuth: getit()),
  );
  getit.registerLazySingleton<DataSourceAuth>(
    () => DatasourseAuthImple(firebaseAuthServices: getit()),
  );
  getit.registerLazySingleton<AuthRepo>(() => AuthRepoImple(dataSourceAuth: getit()));

  getit.registerLazySingleton<PropertyDataSource>(
    () => PropertyDataSourceImple(
      firebaseFirestore: getit(),
      cloudinaryService: getit(),
    ),
  );
  getit.registerLazySingleton<PropertyRepository>(
    () => PropertyRepositoryImple(propertyDataSource: getit()),
  );
  getit.registerLazySingleton<AddPropetryUseCase>(
    () => AddPropetryUseCase(propertyRepository: getit()),
  );

  getit.registerFactory(() => LoginCubit(getit()));  
  getit.registerFactory(() => RegesterCubit(getit()));   
  getit.registerFactory(() => GoogleCubit(getit())); 
  getit.registerFactory(() => PropertyCubit(
    addPropertyUseCase: getit(),
    repository: getit(),   
  )); 

  getit.registerFactory(() => ProfileAdminCubit()); 
  getit.registerLazySingleton<CartHomeAdminDataSource>(() => CartHomeAdminDataSourceImple());
  getit.registerLazySingleton<CartHomeAdminRepo>(() => CartHomeAdminRepoImple(cartHomeAdminDataSource: getit()));
  getit.registerLazySingleton<CartHomeAdminRepoImple>(() => CartHomeAdminRepoImple(cartHomeAdminDataSource: getit()));
  getit.registerLazySingleton<CartHomeAdminCubit>(() => CartHomeAdminCubit(cartHomeAdminRepoImple: getit())); 
  
} 
