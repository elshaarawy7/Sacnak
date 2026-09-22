import 'package:dartz/dartz.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/home_admain/data/model/cart_home_model_admain.dart';

abstract class CartHomeAdminDataSource {
  Future<Either<Fuiler, List<CartHomeModelAdmain>>> getProperties();
} 