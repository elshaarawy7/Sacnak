import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/helper/app_router.dart';
import 'package:sacny/feat/admin/home_admain/domain/entity/entuty_cart_home_admin_model.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_cubit.dart';

class AdminApartmentCard extends StatelessWidget {
  final EntutyCartHomeAdminModel property;
  const AdminApartmentCard({super.key, required this.property});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.homeAdmainDetilsPgae, extra: property).then((_) {
          if (context.mounted) {
            context.read<CartHomeAdminCubit>().getProperties();
          }
        });
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        color: AppColors.white,
        shadowColor: AppColors.darkText.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ApartmentImage(imageUrl: property.imageUrl),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          property.title, 
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.darkText,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _AvailabilityBadge(isAvailable: property.isAvailable),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.bed_outlined,
                        size: 20,
                        color: AppColors.secondaryBlue,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        '${property.availableBeds} سرير',
                        style: TextStyle(
                          color: AppColors.darkText.withValues(alpha: 0.68),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${property.price} ر.س',
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApartmentImage extends StatelessWidget {
  final String imageUrl;
  const _ApartmentImage({required this.imageUrl});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const ColoredBox(
                color: AppColors.lightBg,
                child: Icon(
                  Icons.apartment_rounded,
                  size: 58,
                  color: AppColors.primaryGreen,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  const _AvailabilityBadge({required this.isAvailable});

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final color = isAvailable ? AppColors.primaryGreen : Colors.red.shade700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 5),
          Text(
            isAvailable ? 'متاحة للتأجير' : 'غير متاحة',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
