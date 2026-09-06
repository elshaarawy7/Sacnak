

import 'package:go_router/go_router.dart';
import 'package:sacny/feat/onbourding/presentation/pages/on_bording_page.dart';
import 'package:sacny/feat/onbourding/presentation/pages/onbourding_page_tow.dart';
import 'package:sacny/feat/splash/presentation/pages/splash_page.dart';

class AppRouter {
  
  static const String splashRoute = '/'; 
  static const String onBordingRoute = '/onBordingPage';
  static const String onBordingPageTow = '/onBordingPageTow';

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
    ],
  );
}
