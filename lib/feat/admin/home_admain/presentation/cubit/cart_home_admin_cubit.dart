import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/feat/admin/home_admain/data/repo/cart_home_admin_repo_imple.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_state.dart';

class CartHomeAdminCubit extends Cubit<CartHomeAdminState> {
  final CartHomeAdminRepoImple cartHomeAdminRepoImple;

  CartHomeAdminCubit({required this.cartHomeAdminRepoImple})
    : super(CartHomeAdminInitial()) ; 

    static CartHomeAdminCubit get(BuildContext context) {
      return BlocProvider.of<CartHomeAdminCubit>(context);
    }

  Future<void> getProperties() async {
    emit(CartHomeAdminLoading());
    final result = await cartHomeAdminRepoImple.getProperties();
    result.fold(
      (failure) => emit(CartHomeAdminError(error: failure)),
      (properties) => emit(CartHomeAdminLoaded(properties: properties)),
    );
  }
}
