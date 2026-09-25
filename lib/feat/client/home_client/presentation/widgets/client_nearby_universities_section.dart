import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';

class ClientNearbyUniversitiesSection extends StatelessWidget {
  final List<String> universities;

  const ClientNearbyUniversitiesSection({
    super.key,
    required this.universities,
  });

  @override
  Widget build(BuildContext context) {
    if (universities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: AppColors.secondaryBlue,
                  size: 22,
                ),
              ),
              const Gap(10),
              const Text(
                'الجامعات القريبة',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: universities.map((uni) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondaryBlue.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.secondaryBlue,
                    ),
                    const Gap(6),
                    Text(
                      uni,
                      style: const TextStyle(
                        color: AppColors.secondaryBlue,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
