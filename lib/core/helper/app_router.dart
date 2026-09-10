

import 'package:go_router/go_router.dart';
import 'package:sacny/feat/admin/add_drug/presentation/pages/add_drag_page.dart';
import 'package:sacny/feat/admin/chats_admain/presentation/pages/admain_chats.dart';
import 'package:sacny/feat/admin/home/presentation/pages/home_admain_page.dart';
import 'package:sacny/feat/admin/profile_dmain/presentation/pages/profile_admain.dart';
import 'package:sacny/feat/admin/rote_adman.dart';
import 'package:sacny/feat/auth/presentation/pages/login_page.dart';
import 'package:sacny/feat/auth/presentation/pages/register_page.dart';
import 'package:sacny/feat/choose%20acount/presentation/pages/choose_acount_page.dart';
import 'package:sacny/feat/onbourding/presentation/pages/on_bording_page.dart';
import 'package:sacny/feat/onbourding/presentation/pages/onbourding_page_tow.dart';
import 'package:sacny/feat/splash/presentation/pages/splash_page.dart';

class AppRouter {
  // auth and splsh and oun bourding
  static const String splashRoute = '/'; 
  static const String onBordingRoute = '/onBordingPage';
  static const String onBordingPageTow = '/onBordingPageTow'; 
  static const String LoginPageRote = '/LoginPage' ;
  static const String registerRoute = '/registerPage' ; 
  static const String ChooseAcountRoute = '/ChooseAcountPage';  

  // admain
  static const String HomeAdminPageRote = '/HomeAdminPage'  ;  
  static const String AddDragPageRote = '/AddDragPage';
  static const String AdminChatsPageRote = '/AdminChatsPage';
  static const String ProfileAdmainRote  = '/ProfileAdmain'; 
  static const String AdminRoute = '/RouteAdmin'; 



  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashPage(),
      ), 

      GoRoute( 
        path: onBordingRoute, 
        builder: (context, state) => const OnBordingPageone(),
      ), 

      GoRoute( 
        path: onBordingPageTow, 
        builder: (context, state) => const OnbourdingPageTow(),
      ), 

      GoRoute(
        path: LoginPageRote,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: registerRoute,
        builder: (context, state) => const RegisterPage(),
      ), 

      GoRoute(
        path: ChooseAcountRoute,
        builder: (context, state) => const ChooseAcountPage()
      ),  

      GoRoute(
        path: HomeAdminPageRote,
        builder: (context, state) => const HomeAdmainPage()
      ),  

        GoRoute(
        path: AddDragPageRote,
        builder: (context, state) => const AddDragPage()
      ), 

        GoRoute(
        path: AdminChatsPageRote,
        builder: (context, state) => const AdminChatsPage()
      ), 

        GoRoute(
        path: ProfileAdmainRote,
        builder: (context, state) => const ProfileAdmain()
      ),  

        GoRoute(
        path: AdminRoute,
        builder: (context, state) => const RouteAdmin()
      ),  

    ],
  );
}
