import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/widgets/admin_apartment_card.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_cubit.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_state.dart';

class HomeAdminPageBody extends StatelessWidget {
  const HomeAdminPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartHomeAdminCubit, CartHomeAdminState>(
      builder: (context, state) {
        if (state is CartHomeAdminLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CartHomeAdminError) {
          Fluttertoast.showToast(
            msg: "حدث خطأ: ${state.error}",
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
          );
        }
        // Show list for Loaded state, empty view for others
        final properties = state is CartHomeAdminLoaded ? state.properties : [];

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'عقاراتي',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: AppColors.darkText,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'تابع حالة شققك وتفاصيلها',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: AppColors.darkText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.home_work_outlined,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (properties.isEmpty && state is! CartHomeAdminLoading)
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    'لا توجد عقارات حتى الآن',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverList.separated(
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    return HomeApartmentCard(property: property);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ),
              ),
          ],
        );
      },
    );
  }
}
