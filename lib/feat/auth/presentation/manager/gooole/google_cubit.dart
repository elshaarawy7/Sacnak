import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacny/feat/auth/data/repo/auth_repo.dart';
import 'package:sacny/feat/auth/presentation/manager/gooole/google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  final AuthRepo authRepo;

  static GoogleCubit get(context) => BlocProvider.of(context);

  GoogleCubit(this.authRepo) : super(GoogleInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(GoogleFailure(error: failure)),
      (userModel) => emit(GoogleSuccess(userModel: userModel)),
    );
  }
}
