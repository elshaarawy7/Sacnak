import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/widgets/admin_apartment_card.dart';
import 'package:sacny/core/widgets/text_filed.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_cubit.dart';
import 'package:sacny/feat/admin/home_admain/presentation/cubit/cart_home_admin_state.dart';

class HomePageClientBody extends StatefulWidget {
  const HomePageClientBody({super.key});

  @override
  State<HomePageClientBody> createState() => _HomePageClientBodyState();
}

class _HomePageClientBodyState extends State<HomePageClientBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartHomeAdminCubit, CartHomeAdminState>(
      builder: (context, state) {
        if (state is CartHomeAdminLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final allProperties = state is CartHomeAdminLoaded
            ? state.properties
            : [];
        final searchQuery = _searchController.text.trim().toLowerCase();

        final filteredProperties = searchQuery.isEmpty
            ? allProperties
            : allProperties
                  .where(
                    (prop) => prop.title.toLowerCase().contains(searchQuery),
                  )
                  .toList();

        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: Gap(70)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: CusteomFromTextFiled(
                  labelText: "ابحث عن المدينة أو الجامعة",
                  hintText: "جامعة القاهرة , مدينة نصر",
                  controller: _searchController,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: Gap(16)),
            if (filteredProperties.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'لا توجد عقارات متاحة',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverList.separated(
                  itemCount: filteredProperties.length,
                  itemBuilder: (context, index) {
                    final property = filteredProperties[index];
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
