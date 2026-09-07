import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo.dart';
import 'package:sacny/feat/auth/presentation/manager/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final phoneOrEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoading());
    final result = await authRepo.Login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
