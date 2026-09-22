import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/home_admain/domain/entity/entuty_cart_home_admin_model.dart';

abstract class CartHomeAdminRepo {
  Future<Either<Fuiler, List<EntutyCartHomeAdminModel>>> getProperties();
} 