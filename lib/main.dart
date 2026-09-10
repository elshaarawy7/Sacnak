import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/core/helper/app_router.dart';
import 'package:sacny/core/server/geti.dart';
import 'package:sacny/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  getsetUp();
  runApp(const SacnackApp());
}

class SacnackApp extends StatelessWidget {
  const SacnackApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen),

        textTheme: GoogleFonts.cairoTextTheme(
          const TextTheme(
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            bodyMedium: TextStyle(fontSize: 14),
            titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
