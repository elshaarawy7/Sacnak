import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/feat/admin/profile_dmain/data/datasource/profile_admain_data_source_imple.dart';
import 'package:sacny/feat/admin/profile_dmain/data/repo/profile_admain_repo_imple.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/cubit/profile_admain_state.dart';

class ProfileAdminCubit extends Cubit<ProfileAdminState> {
  ProfileAdminCubit() : super(ProfileAdminInitial());

  static ProfileAdminCubit get(context) => BlocProvider.of(context); 

  final ProfileAdmainRepoImple profileAdmainRepoImple = ProfileAdmainRepoImple(
    profileAdmainDataSource: ProfileAdmainDataSourceImple(),
  );

  final ImagePicker imagePicker = ImagePicker();
  int? selectedImageIndex;
  XFile? selectedImage;

  Future<void> pickImage() async {
    try {
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage = pickedFile;
        selectedImageIndex = 0;
        emit(ProfileAdminSuccess());
      } else {
        emit(ProfileAdminFailure(errorMessage: 'No image selected.'));
      }
    } catch (e) {
      emit(ProfileAdminFailure(errorMessage: 'Failed to pick image: $e'));
    }
  }  

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(ProfileAdminLoading());
      try {
        final result = await profileAdmainRepoImple.updateProfile(
          nameController.text.trim(),
          phoneController.text.trim(),
          selectedImage?.path,
        );

        result.fold(
          (failure) => emit(ProfileAdminFailure(errorMessage: failure.message)),
          (_) => emit(ProfileAdminSuccess()),
        );
      } catch (e) {
        emit(ProfileAdminFailure(errorMessage: 'Failed to update profile: $e'));
      }
    }
  }
}