import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/feat/client/profile_client/data/datasource/profile_client_data_source_imple.dart';
import 'package:sacny/feat/client/profile_client/data/repo/profile_client_repo_imple.dart';
import 'package:sacny/feat/client/profile_client/presentation/cubit/profile_admain_state.dart';

class ProfileClientCubit extends Cubit<ProfileClientState> {
  ProfileClientCubit() : super(ProfileClientInitial());

  static ProfileClientCubit get(BuildContext context) => BlocProvider.of(context); 

  final ProfileClientRepoImple profileClientRepoImple = ProfileClientRepoImple(
    profileClientDataSource: ProfileClientDataSourceImple(),
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
        emit(ProfileClientSuccess());
      } else {
        emit(ProfileClientFailure(errorMessage: 'No image selected.'));
      }
    } catch (e) {
      emit(ProfileClientFailure(errorMessage: 'Failed to pick image: $e'));
    }
  }  

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(ProfileClientLoading());
      try {
        final result = await profileClientRepoImple.updateProfile(
          nameController.text.trim(),
          phoneController.text.trim(),
          selectedImage?.path,
        );

        result.fold(
          (failure) => emit(ProfileClientFailure(errorMessage: failure.message)),
          (_) => emit(ProfileClientSuccess()),
        );
      } catch (e) {
        emit(ProfileClientFailure(errorMessage: 'Failed to update profile: $e'));
      }
    }
  }
}