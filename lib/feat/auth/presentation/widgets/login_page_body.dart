import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/helper/app_router.dart';
import 'package:sacny/core/widgets/custom_batton.dart';
import 'package:sacny/feat/auth/presentation/manager/login/login_cubit.dart';
import 'package:sacny/feat/auth/presentation/manager/login/login_state.dart';
import 'package:sacny/feat/auth/presentation/widgets/auth_batton.dart';
import 'package:sacny/feat/auth/presentation/widgets/auth_header_logo.dart';
import 'package:sacny/feat/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:sacny/feat/auth/presentation/widgets/social_login_button.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  late int _selectedTab;
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Fluttertoast.showToast(
                  msg: "تم تسجيل الدخول بنجاح",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else if (state is LoginFailure) {
                Fluttertoast.showToast(
                  msg: state.errorMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },

            builder: (context, state) {
              final loginCubit = LoginCubit.get(context);
              return Form(
                key: loginCubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AuthHeaderLogo(),

                    const Gap(20),

                    Text(
                      "مرحبا بك من جديد",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Gap(20),

                    CustomAuthTextField(
                      labelArabic: "Email",
                      labelEnglish: "Enter Your Email",
                      hintText: "user@gmail.com",
                      prefixIcon: Icons.email,
                      controller: loginCubit.emailController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "يرجى إدخال رقم الهاتف أو البريد الإلكتروني";
                        }
                        return null;
                      },
                    ),
                    const Gap(20),

                    CustomAuthTextField(
                      labelArabic: "كلمة المرور",
                      labelEnglish: "Password",
                      headerIcon: Icons.lock_outline,
                      hintText: "••••••••••••",
                      prefixIcon: Icons.key_outlined,
                      obscureText: _obscurePassword,
                      controller: loginCubit.passwordController,
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
                    Gap(20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: AppColors.primaryGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _rememberMe = val ?? false;
                                    });
                                  },
                                ),
                              ),
                              const Gap(6),
                              const Text(
                                "تذكرني / Remember",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF475569),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "سيتم إرسال رابط إعادة تعيين كلمة المرور",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "نسيت كلمة المرور؟",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Gap(20),

                    state is LoginLoading
                        ? const CircularProgressIndicator()
                        : CustomBatton(
                            text: "تسجيل الدخول",
                            ontap: () {
                              LoginCubit.get(context).loginUser();
                            },
                          ),

                    Gap(20),

                    AuthButton(
                      text: "انشاء حساب جديد الان ",
                      ontap: () {
                        context.push(AppRouter.registerRoute);
                      },
                    ),

                    Gap(12),

                    const Gap(18),
                    SocialLoginButton(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "تسجيل الدخول عبر Google قيد الإعداد",
                            ),
                          ),
                        );
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
