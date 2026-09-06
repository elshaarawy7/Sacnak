import 'package:flutter/material.dart';

class OnboardingBadge extends StatelessWidget {
  const OnboardingBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.width,
    this.height = 30,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
