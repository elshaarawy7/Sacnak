import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo.dart';
import 'package:sacny/feat/auth/presentation/manager/regester/regester_state.dart';

class RegesterCubit extends Cubit<RegesterState> {
  RegesterCubit(this.authRepo) : super(RegesterInitial());
  final AuthRepo authRepo;
  static RegesterCubit get(context) => BlocProvider.of<RegesterCubit>(context);
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    emit(RegesterLoading());
    final result = await authRepo.Register(
      email: emailController.text.trim(),
      password: passwordController.text,
      phone: phoneController.text.trim(),
      name: nameController.text.trim(),
    );

    result.fold(
      (failure) => emit(RegesterFailure(failure.message)),
      (user) => emit(RegesterSuccess(user)),
    );
  }
}
