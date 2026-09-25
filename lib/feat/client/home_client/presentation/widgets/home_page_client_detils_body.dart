import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/client/home_client/presentation/cubit/client_property_details_cubit.dart';
import 'package:sacny/feat/client/home_client/presentation/cubit/client_property_details_state.dart';
import 'package:sacny/feat/client/home_client/presentation/widgets/client_amenities_section.dart';
import 'package:sacny/feat/client/home_client/presentation/widgets/client_details_image_header.dart';
import 'package:sacny/feat/client/home_client/presentation/widgets/client_nearby_universities_section.dart';
import 'package:sacny/feat/client/home_client/presentation/widgets/client_property_info_section.dart';

class HomePageClientDetilsBody extends StatelessWidget {
  final String propertyId;

  const HomePageClientDetilsBody({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientPropertyDetailsCubit, ClientPropertyDetailsState>(
      builder: (context, state) {
        if (state is ClientPropertyDetailsLoading) {
          return const Scaffold(
            backgroundColor: AppColors.lightBg,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            ),
          );
        }

        if (state is ClientPropertyDetailsError) {
          return Scaffold(
            backgroundColor: AppColors.lightBg,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.darkText),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline_rounded,
                        size: 64, color: Colors.red),
                    const Gap(16),
                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText,
                      ),
                    ),
                    const Gap(20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        context
                            .read<ClientPropertyDetailsCubit>()
                            .fetchPropertyDetails(propertyId);
                      },
                      child: const Text(
                        'إعادة المحاولة',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is ClientPropertyDetailsLoaded) {
          final property = state.property;

          return Scaffold(
            backgroundColor: AppColors.lightBg,
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ClientDetailsImageHeader(
                    images: property.images,
                    isAvailable: property.status =="available",
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      ClientPropertyInfoSection(property: property),
                      const Gap(16),
                      ClientNearbyUniversitiesSection(
                        universities: property.nearbyUniversities,
                      ),
                      if (property.nearbyUniversities.isNotEmpty) const Gap(16),
                      ClientAmenitiesSection(
                        amenities: property.amenities,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'الإجمالي شهرياً',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${property.price.toInt()} ر.س',
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'تم استلام طلب التواصل بنجاح',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: AppColors.primaryGreen,
                          ),
                        );
                      },
                      icon: const Icon(Icons.send_rounded,
                          color: Colors.white, size: 18),
                      label: const Text(
                        'طلب حجز / استفسار',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}