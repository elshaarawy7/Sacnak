import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/home/presentation/pages/home_admain_page.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/pages/admain_chats.dart';
import 'package:sacny/feat/admin/add_drug/presentation/pages/add_drag_page.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/pages/profile_admain.dart';

class RouteAdmin extends StatefulWidget {
  const RouteAdmin({super.key});

  static const String routeName = '/RouteAdmin';

  @override
  State<RouteAdmin> createState() => _RouteAdminState();
}

class _RouteAdminState extends State<RouteAdmin> {
  int _currentIndex = 0;

  /// قائمة الصفحات المُضافة في IndexedStack
  /// IndexedStack يحافظ على حالة (State) كل صفحة عند التنقل بينها
  final List<Widget> _pages = const [
    HomeAdmainPage(),   // index 0 - Home
    AdminChatsPage(),   // index 1 - Chats
    AddDragPage(),      // index 2 - Add Drug
    ProfileAdmain(),    // index 3 - Profile
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.darkText.withOpacity(0.45),
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      elevation: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          activeIcon: Icon(Icons.chat_bubble_rounded),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline_rounded),
          activeIcon: Icon(Icons.add_circle_rounded),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
