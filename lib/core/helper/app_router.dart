

import 'package:go_router/go_router.dart';
import 'package:sacny/feat/admin/home/presentation/pages/home_admain_page.dart';
import 'package:sacny/feat/auth/presentation/pages/login_page.dart';
import 'package:sacny/feat/auth/presentation/pages/register_page.dart';
import 'package:sacny/feat/choose%20acount/presentation/pages/choose_acount_page.dart';
import 'package:sacny/feat/onbourding/presentation/pages/on_bording_page.dart';
import 'package:sacny/feat/onbourding/presentation/pages/onbourding_page_tow.dart';
import 'package:sacny/feat/splash/presentation/pages/splash_page.dart';

class AppRouter {
  
  static const String splashRoute = '/'; 
  static const String onBordingRoute = '/onBordingPage';
  static const String onBordingPageTow = '/onBordingPageTow'; 
  static const String LoginPageRote = '/LoginPage' ;
  static const String registerRoute = '/registerPage' ; 
  static const String ChooseAcountRoute = '/ChooseAcountPage'; 
  static const String HomeAdminPageRote = '/HomeAdminPage'  ; 

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
    ],
  );
}
