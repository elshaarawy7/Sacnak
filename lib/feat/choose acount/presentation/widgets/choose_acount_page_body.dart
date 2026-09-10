import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/helper/app_router.dart';
import 'package:sacny/core/widgets/custom_batton.dart';

class ChooseAcountPageBody extends StatefulWidget {
  const ChooseAcountPageBody({super.key});

  @override
  State<ChooseAcountPageBody> createState() => _ChooseAcountPageBodyState();
}

class _ChooseAcountPageBodyState extends State<ChooseAcountPageBody> {
  // 0: Property Owner (صاحب عقار), 1: Tenant (مستأجر)
  int _selectedRoleIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              // Top Drag Handle Indicator
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(28),

              // Title and Subtitle
              const Text(
                'كيف تريد استخدام التطبيق؟',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              const Text(
                'اختر دورك للمتابعة',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(32),

              // Role Cards
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Property Owner Card
                    _buildRoleCard(
                      index: 0,
                      title: 'صاحب عقار',
                      englishTitle: 'Property Owner',
                      description: 'أضف عقاراتك وتواصل مع المستأجرين',
                      icon: Icons.domain_rounded,
                      pills: const [
                        _RolePill(
                          icon: Icons.verified_user_outlined,
                          text: 'عقود موثقة',
                        ),
                        _RolePill(
                          icon: Icons.calendar_today_outlined,
                          text: 'إدارة الحجوزات',
                        ),
                      ],
                    ),
                    const Gap(16),

                    // Tenant Card
                    _buildRoleCard(
                      index: 1,
                      title: 'مستأجر',
                      englishTitle: 'Tenant',
                      description: 'ابحث عن شقة مناسبة بالقرب منك',
                      icon: Icons.vpn_key_rounded,
                      pills: const [
                        _RolePill(
                          icon: Icons.percent_rounded,
                          text: 'بدون عمولة سمسار',
                        ),
                        _RolePill(
                          icon: Icons.school_outlined,
                          text: 'قريب من جامعتك',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(16),

              // Continue Button (CustomBatton)
              CustomBatton(
                text: 'متابعة',
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
                ontap: () {
                  context.push(AppRouter.AdminRoute);
                },
              ),
              const Gap(14),

              // Reassurance Note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.history_toggle_off_rounded,
                    size: 16,
                    color: Color(0xFF64748B),
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'يمكنك تغيير دورك أو التبديل في أي وقت من الإعدادات',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const Gap(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required int index,
    required String title,
    required String englishTitle,
    required String description,
    required IconData icon,
    required List<_RolePill> pills,
  }) {
    final isSelected = _selectedRoleIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRoleIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryGreen
                : const Color(0xFFE2E8F0),
            width: isSelected ? 2.0 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primaryGreen.withOpacity(0.08)
                  : Colors.black.withOpacity(0.02),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radio / Checkbox Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primaryGreen
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryGreen
                          : const Color(0xFFCBD5E1),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 15, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 14),

                // Title, English Subtitle & Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkText,
                            ),
                          ),
                          Text(
                            englishTitle,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.primaryGreen
                                  : const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF64748B),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                // Icon Box
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryGreen
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                    size: 24,
                  ),
                ),
              ],
            ),
            const Gap(16),

            // Value Proposition Pills
            Row(
              children: pills.map((pill) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryGreen.withOpacity(0.06)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryGreen.withOpacity(0.25)
                            : const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          pill.icon,
                          size: 13,
                          color: isSelected
                              ? AppColors.primaryGreen
                              : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          pill.text,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.primaryGreen
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RolePill {
  final IconData icon;
  final String text;

  const _RolePill({required this.icon, required this.text});
}
