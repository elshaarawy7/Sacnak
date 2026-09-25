import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';

class ClientAmenitiesSection extends StatelessWidget {
  final List<String> amenities;

  const ClientAmenitiesSection({
    super.key,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    if (amenities.isEmpty) {
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
                  color: AppColors.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.stars_rounded,
                  color: AppColors.primaryGreen,
                  size: 22,
                ),
              ),
              const Gap(10),
              const Text(
                'المميزات والخدمات المتاحة',
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
            children: amenities.map((amenity) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryGreen.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getAmenityIcon(amenity),
                      size: 18,
                      color: AppColors.primaryGreen,
                    ),
                    const Gap(8),
                    Text(
                      amenity,
                      style: const TextStyle(
                        color: AppColors.darkText,
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

  IconData _getAmenityIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('واي') || lower.contains('نت') || lower.contains('wifi')) {
      return Icons.wifi_rounded;
    }
    if (lower.contains('تكييف') || lower.contains('ac')) {
      return Icons.ac_unit_rounded;
    }
    if (lower.contains('مصعد') || lower.contains('اسانسير') || lower.contains('elevator')) {
      return Icons.elevator_rounded;
    }
    if (lower.contains('أمن') || lower.contains('حراسة') || lower.contains('security')) {
      return Icons.security_rounded;
    }
    if (lower.contains('غسالة') || lower.contains('washing')) {
      return Icons.local_laundry_service_rounded;
    }
    if (lower.contains('مطبخ') || lower.contains('kitchen')) {
      return Icons.kitchen_rounded;
    }
    if (lower.contains('تلفزيون') || lower.contains('شاشة') || lower.contains('tv')) {
      return Icons.tv_rounded;
    }
    if (lower.contains('بلكونة') || lower.contains('شرفة') || lower.contains('balcony')) {
      return Icons.balcony_rounded;
    }
    if (lower.contains('سخان') || lower.contains('غاز') || lower.contains('heater')) {
      return Icons.water_damage_rounded;
    }
    return Icons.check_circle_outline_rounded;
  }
}
