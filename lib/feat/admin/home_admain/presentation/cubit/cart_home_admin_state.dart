import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/home_admain/domain/entity/entuty_cart_home_admin_model.dart';

abstract class CartHomeAdminState {} 

class CartHomeAdminInitial extends CartHomeAdminState {} 

class CartHomeAdminLoading extends CartHomeAdminState {} 

class CartHomeAdminLoaded extends CartHomeAdminState { 

  final List<EntutyCartHomeAdminModel> properties; 
  CartHomeAdminLoaded({required this.properties});
} 

class CartHomeAdminError extends CartHomeAdminState { 

  final Fuiler error; 
  CartHomeAdminError({required this.error});
} 