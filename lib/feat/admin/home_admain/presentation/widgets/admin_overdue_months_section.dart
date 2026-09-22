import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';

class AdminOverdueMonthsSection extends StatelessWidget {
  const AdminOverdueMonthsSection({super.key, required this.months});

  final List<String> months;

  @override
  Widget build(BuildContext context) {
    final hasOverdueMonths = months.isNotEmpty;

    return _DetailsSection(
      title: 'الشهور المتأخرة',
      icon: Icons.warning_amber_rounded,
      iconColor: hasOverdueMonths
          ? Colors.orange.shade800
          : AppColors.primaryGreen,
      child: hasOverdueMonths
          ? Wrap(
              spacing: 8,
              runSpacing: 8,
              children: months
                  .map(
                    (month) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        month,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.orange.shade900,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          : const Text(
              'لا توجد شهور متأخرة',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.darkText.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 21),
              const SizedBox(width: 8),
              Text(
                title,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: AppColors.darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
