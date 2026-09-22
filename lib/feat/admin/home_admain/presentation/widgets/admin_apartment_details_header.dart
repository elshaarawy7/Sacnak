import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';

class AdminApartmentDetailsHeader extends StatelessWidget {
  const AdminApartmentDetailsHeader({
    super.key,
    required this.title,
    required this.price,
    required this.totalBeds,
    required this.availableBeds,
  });

  final String title;
  final int price;
  final int totalBeds;
  final int availableBeds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryGreen.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: availableBeds > 0
                      ? AppColors.primaryGreen.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  availableBeds > 0 ? 'متاحة' : 'مكتملة',
                  style: TextStyle(
                    color: availableBeds > 0
                        ? AppColors.primaryGreen
                        : Colors.red.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _SummaryItem(
                icon: Icons.payments_outlined,
                label: 'السعر الشهري',
                value: '$price ج.م',
              ),
              const SizedBox(width: 10),
              _SummaryItem(
                icon: Icons.bed_outlined,
                label: 'عدد السراسر المتاحه',
                value: '$availableBeds من $totalBeds',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: AppColors.lightBg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primaryGreen, size: 20),
            const SizedBox(height: 7),
            Text(
              label,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: AppColors.darkText.withValues(alpha: 0.56),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: AppColors.darkText,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
