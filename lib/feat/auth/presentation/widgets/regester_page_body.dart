import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/widgets/custom_batton.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneOrEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneOrEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AuthHeaderLogo(),

                const Gap(20),

                const Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const Gap(20),

                // حقل اسم المستخدم
                CustomAuthTextField(
                  labelArabic: "الاسم الكامل",
                  labelEnglish: "Full Name",
                  headerIcon: Icons.person_outline,
                  hintText: "أدخل اسمك الكامل",
                  prefixIcon: Icons.badge_outlined,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يرجى إدخال الاسم";
                    }
                    return null;
                  },
                ),

                const Gap(20),

                // حقل الهاتف أو البريد
                CustomAuthTextField(
                  labelArabic: "رقم الهاتف / البريد",
                  labelEnglish: "Phone / Email",
                  headerIcon: Icons.phone_iphone_outlined,
                  hintText: "+20 010/011/012/015 أو student@cu.edu.eg",
                  prefixIcon: Icons.alternate_email,
                  controller: _phoneOrEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "يرجى إدخال رقم الهاتف أو البريد الإلكتروني";
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
                  controller: _passwordController,
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
                    if (_formKey.currentState!.validate()) {
                      // Perform Register logic
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("إنشاء حساب عبر Google قيد الإعداد"),
                      ),
                    );
                  },
                ),

                const Gap(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}