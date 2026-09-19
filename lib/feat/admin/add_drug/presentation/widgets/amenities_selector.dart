import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';

class AmenityItem {
  final String id;
  final String titleAr;
  final String titleEn;
  bool isSelected;

  AmenityItem({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    this.isSelected = false,
  });
}

class AmenitiesSelector extends StatefulWidget {
  final ValueChanged<List<AmenityItem>>? onSelectionChanged;

  const AmenitiesSelector({super.key, this.onSelectionChanged});

  @override
  State<AmenitiesSelector> createState() => _AmenitiesSelectorState();
}

class _AmenitiesSelectorState extends State<AmenitiesSelector> {
  final List<AmenityItem> _amenities = [
    AmenityItem(
      id: 'wifi',
      titleAr: 'واي فاي فائق السرعة',
      titleEn: 'High-speed Fiber Wi-Fi',
      isSelected: true,
    ),
    AmenityItem(
      id: 'ac',
      titleAr: 'تكييف هوائي (A/C)',
      titleEn: 'Air Conditioning',
      isSelected: true,
    ),
    AmenityItem(
      id: 'desk',
      titleAr: 'مكتب وكرسي مخصص للمذاكرة',
      titleEn: 'Study Desk & Ergonomic Chair',
      isSelected: true,
    ),
    AmenityItem(
      id: 'washing',
      titleAr: 'غسالة ملابس',
      titleEn: 'Automatic Washing Machine',
      isSelected: true,
    ),
    AmenityItem(
      id: 'security',
      titleAr: 'أمن وحراسة بالعمارة',
      titleEn: 'Security & CCTV 24/7',
      isSelected: true,
    ),
    AmenityItem(
      id: 'elevator',
      titleAr: 'أسانسير ومصعد شغال',
      titleEn: 'Modern Elevator Access',
      isSelected: true,
    ),
    AmenityItem(
      id: 'heater',
      titleAr: 'سخان مياه فوري',
      titleEn: 'Instant Water Heater',
      isSelected: true,
    ),
    AmenityItem(
      id: 'kitchen',
      titleAr: 'ثلاجة وبوتجاز متكامل',
      titleEn: 'Equipped Kitchenette',
      isSelected: false,
    ),
  ];

  void _toggleAmenity(int index) {
    setState(() {
      _amenities[index].isSelected = !_amenities[index].isSelected;
    });
    widget.onSelectionChanged?.call(
      _amenities.where((a) => a.isSelected).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'وسائل الراحة والتجهيزات',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '(طلاب ومغتربون) Amenities',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Gap(14),

        // Grid of Amenities
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _amenities.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.85,
          ),
          itemBuilder: (context, index) {
            final item = _amenities[index];
            final isSelected = item.isSelected;

            return GestureDetector(
              onTap: () => _toggleAmenity(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryGreen.withValues(alpha: 0.03)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryGreen
                        : Colors.grey.shade300,
                    width: isSelected ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    // Text Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.titleAr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.black87
                                  : Colors.grey.shade800,
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            item.titleEn,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(6),

                    // Checkbox
                    Transform.scale(
                      scale: 0.95,
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (_) => _toggleAmenity(index),
                        activeColor: AppColors.primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
