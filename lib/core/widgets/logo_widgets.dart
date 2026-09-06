import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/constant/images_app.dart';

class LogoWidgets extends StatelessWidget {
  const LogoWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGreen.withValues(alpha: 0.24),
                      blurRadius: 30,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        ImagesApp
                            .LogoApp, // استبدل 'logo.png' بمسار الصورة الفعلي لشعار التطبيق ,
                        width: 110,
                        height: 110,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
  }
}