import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/home_admain/data/datasourse/cart_home_admin_datasourse.dart';
import 'package:sacny/feat/admin/home_admain/data/repo/cart_home_admin_repo.dart';
import 'package:sacny/feat/admin/home_admain/domain/entity/entuty_cart_home_admin_model.dart';

class CartHomeAdminRepoImple extends CartHomeAdminRepo {
  CartHomeAdminDataSource cartHomeAdminDataSource;

  CartHomeAdminRepoImple({required this.cartHomeAdminDataSource});
  @override
  Future<Either<Fuiler, List<EntutyCartHomeAdminModel>>> getProperties() async {
    return await cartHomeAdminDataSource.getProperties();
  } 
} 