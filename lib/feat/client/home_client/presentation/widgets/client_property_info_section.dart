import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/client/home_client/domain/entity/client_property_details_entity.dart';

class ClientPropertyInfoSection extends StatelessWidget {
  final ClientPropertyDetailsEntity property;

  const ClientPropertyInfoSection({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Price and Area Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'سعر الإيجار',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Text(
                        '${property.price.toInt()}',
                        style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Gap(4),
                      const Text(
                        'ر.س / شهرياً',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.square_foot_rounded,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    const Gap(6),
                    Text(
                      '${property.area.toInt()} م²',
                      style: const TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(16),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const Gap(16),

          // Address Card (City, Street, Building No, Apartment No)
          const Text(
            'تفاصيل العنوان والموقع',
            style: TextStyle(
              color: AppColors.darkText,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _buildAddressRow(
                  icon: Icons.location_city_rounded,
                  title: 'المدينة:',
                  value: property.city.isNotEmpty ? property.city : 'غير محدد',
                ),
                const Divider(height: 16, thickness: 0.5),
                _buildAddressRow(
                  icon: Icons.edit_road_rounded,
                  title: 'اسم الشارع:',
                  value: property.street.isNotEmpty ? property.street : 'غير محدد',
                ),
                const Divider(height: 16, thickness: 0.5),
                Row(
                  children: [
                    Expanded(
                      child: _buildAddressRow(
                        icon: Icons.business_rounded,
                        title: 'رقم العمارة:',
                        value: property.buildingNumber.isNotEmpty
                            ? property.buildingNumber
                            : '-',
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                      child: VerticalDivider(thickness: 1, color: Colors.grey),
                    ),
                    Expanded(
                      child: _buildAddressRow(
                        icon: Icons.door_front_door_outlined,
                        title: 'رقم الشقة:',
                        value: property.apartmentNumber.isNotEmpty
                            ? property.apartmentNumber
                            : '-',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Gap(18),

          // Specs Grid (Bedrooms, Bathrooms, Available Beds, Rooms)
          Row(
            children: [
              Expanded(
                child: _buildSpecCard(
                  icon: Icons.bed_outlined,
                  title: 'الأسرة المتاحة',
                  value: '${property.availableBeds} من ${property.bedrooms}',
                  color: AppColors.secondaryBlue,
                ),
              ),
              const Gap(10),
              Expanded(
                child: _buildSpecCard(
                  icon: Icons.meeting_room_outlined,
                  title: 'عدد الغرف',
                  value: '${property.rooms} غرف',
                  color: AppColors.primaryGreen,
                ),
              ),
              const Gap(10),
              Expanded(
                child: _buildSpecCard(
                  icon: Icons.bathtub_outlined,
                  title: 'الحمامات',
                  value: '${property.bathrooms}',
                  color: AppColors.accentOrange,
                ),
              ),
            ],
          ),

          if (property.insurance != null || property.isIncludesBills) ...[
            const Gap(14),
            Row(
              children: [
                if (property.isIncludesBills)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline,
                              color: Colors.green.shade700, size: 16),
                          const Gap(6),
                          Text(
                            'شامل الفواتير',
                            style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (property.isIncludesBills && property.insurance != null)
                  const Gap(10),
                if (property.insurance != null)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.shield_outlined,
                              color: Colors.orange.shade800, size: 16),
                          const Gap(6),
                          Text(
                            'تأمين: ${property.insurance!.toInt()} ر.س',
                            style: TextStyle(
                              color: Colors.orange.shade900,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddressRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryGreen),
        const Gap(8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(6),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.darkText,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const Gap(4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(2),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
