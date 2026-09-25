import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/pages/admain_chats.dart';
import 'package:sacny/feat/client/chats_client/presentation/pages/chate_page_client.dart';
import 'package:sacny/feat/client/home_client/presentation/pages/home_page_client.dart';
import 'package:sacny/feat/client/profile_client/presentation/pages/profile_page_client.dart';

class RoteClient extends StatefulWidget {
  const RoteClient ({super.key});

  static const String routeName = '/RoteClient';

  @override
  State<RoteClient > createState() => _RouteAdminState();
}

class _RouteAdminState extends State<RoteClient> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePageClient() , 
    ProfilePageClient() ,  
    ChatePageClient() ,
          

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
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
