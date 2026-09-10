import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/helper/app_router.dart';
import 'package:sacny/core/widgets/custom_batton.dart';
import 'package:sacny/feat/auth/presentation/manager/login/login_state.dart';
import 'package:sacny/feat/auth/presentation/manager/regester/regester_cubit.dart';
import 'package:sacny/feat/auth/presentation/manager/regester/regester_state.dart';
import 'package:sacny/feat/auth/presentation/widgets/auth_batton.dart';
import 'package:sacny/feat/auth/presentation/widgets/auth_header_logo.dart';
import 'package:sacny/feat/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:sacny/feat/auth/presentation/widgets/social_login_button.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {
  bool _obscurePassword = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: BlocConsumer<RegesterCubit, RegesterState>(
            listener: (context, state) {
              if (state is RegesterSuccess) {
                Fluttertoast.showToast(
                  msg: 'تم انشاء الحساب بنجاح',
                  backgroundColor: Colors.green,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  fontSize: 16.0,
                ); 

                context.push(AppRouter.ChooseAcountRoute) ; 
              } 


              if (state is RegesterFailure) {
                Fluttertoast.showToast(
                  msg: state.errorMessage,
                  backgroundColor: Colors.red,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
            builder: (context, state) {
              final registerCubit = context.read<RegesterCubit>();
              return Form(
                key: registerCubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AuthHeaderLogo(),

                    const Gap(20),

                    const Text(
                      "إنشاء حساب جديد",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Gap(20),

                    // حقل اسم المستخدم
                    CustomAuthTextField(
                      labelArabic: "الاسم الكامل",
                      labelEnglish: "Full Name",
                      headerIcon: Icons.person_outline,
                      hintText: "أدخل اسمك الكامل",
                      prefixIcon: Icons.badge_outlined,
                      controller: registerCubit.nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يرجى إدخال الاسم";
                        }
                        return null;
                      },
                    ),

                    const Gap(20),

                    // حقل البريد الإلكتروني
                    CustomAuthTextField(
                      labelArabic: "البريد الإلكتروني",
                      labelEnglish: "Email",
                      headerIcon: Icons.email_outlined,
                      hintText: "student@cu.edu.eg",
                      prefixIcon: Icons.alternate_email,
                      controller: registerCubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يرجى إدخال البريد الإلكتروني";
                        }
                        if (!value.contains('@')) {
                          return "يرجى إدخال بريد إلكتروني صحيح";
                        }
                        return null;
                      },
                    ),

                    const Gap(20),

                    // حقل كلمة المرور
                    CustomAuthTextField(
                      labelArabic: "كلمة المرور",
                      labelEnglish: "Password",
                      headerIcon: Icons.lock_outline,
                      hintText: "••••••••••••",
                      prefixIcon: Icons.key_outlined,
                      obscureText: _obscurePassword,
                      controller: registerCubit.passwordController,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade500,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "كلمة المرور يجب أن لا تقل عن 6 أحرف";
                        }
                        return null;
                      },
                    ),

                    const Gap(20),

                    // زر إنشاء الحساب
                    CustomBatton(
                      text: "إنشاء حساب",
                      ontap: () {
                        if (registerCubit.formKey.currentState!.validate()) {
                          registerCubit.registerUser();
                        }
                      },
                    ),

                    const Gap(20),

                    // زر العودة لتسجيل الدخول
                    AuthButton(
                      text: "لديك حساب بالفعل؟ تسجيل الدخول",
                      ontap: () {
                        context.pop();
                      },
                    ),

                    const Gap(18),

                    SocialLoginButton(
                      onTap: () {
                        registerCubit.signInWithGoogle();
                      },
                    ),

                    const Gap(16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
