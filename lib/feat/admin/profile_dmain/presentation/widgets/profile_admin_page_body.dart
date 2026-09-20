import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/widgets/custom_batton.dart';
import 'package:sacny/core/widgets/text_filed.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/cubit/profile_admain_cubit.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/cubit/profile_admain_state.dart';

class ProfileAdminPageBody extends StatelessWidget {
  const ProfileAdminPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
      listener: (context, state) {
        if (state is ProfileAdminFailure) {
          Fluttertoast.showToast(
            msg: state.errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        } else if (state is ProfileAdminSuccess) {
          Fluttertoast.showToast(
            msg: 'Profile updated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        final profileCubit = ProfileAdminCubit.get(context);

        return SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: profileCubit.formKey,
                child: Column(
                  children: [
                  const Gap(100),
                  GestureDetector(
                    onTap: () {
                      profileCubit.pickImage();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primaryGreen,
                          width: 3,
                        ),
                      ),
                      child: profileCubit.selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(profileCubit.selectedImage!.path),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : Center(
                              child: Icon(
                                Icons.person,
                                size: 75,
                                color: Colors.grey.shade400,
                              ),
                            ),
                    ),
                  ),
                  const Gap(30),
                  CusteomFromTextFiled(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    controller: profileCubit.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CusteomFromTextFiled(
                    labelText: 'Phone',
                    hintText: 'Enter your phone number',
                    controller: profileCubit.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CustomBatton(
                    text: 'Update',
                    ontap: () {
                      profileCubit.updateProfile();
                    },
                  ),
                  const Gap(20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}