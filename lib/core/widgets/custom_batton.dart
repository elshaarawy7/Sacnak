import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';

class CustomBatton extends StatelessWidget {
  const CustomBatton({
    super.key,
    required this.text,
    this.ontap,
    this.icon,
  });

  final String text;
  final VoidCallback? ontap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 62,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                icon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}