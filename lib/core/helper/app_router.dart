

import 'package:go_router/go_router.dart';
import 'package:sacny/feat/onbourding/presentation/pages/on_bording_page.dart';
import 'package:sacny/feat/splash/presentation/pages/splash_page.dart';

class AppRouter {
  
  static const String splashRoute = '/'; 
  static const String onBordingRoute = '/onBordingPage';

  static final GoRouter router = GoRouter(
    initialLocation: splashRoute,
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashPage(),
      ), 

      GoRoute( 
        path: onBordingRoute, 
        builder: (context, state) => const OnBordingPage(),
      ),
    ],
  );
}
