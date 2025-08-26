import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'data/datasources/database_helper.dart';
import 'data/repositories/mother_repository_impl.dart';
import 'data/repositories/baby_repository_impl.dart';
import 'data/repositories/recommendation_repository_impl.dart';
import 'presentation/providers/app_provider.dart';
import 'presentation/providers/mother_provider.dart';
import 'presentation/providers/baby_provider.dart';
import 'presentation/providers/recommendation_provider.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  // Initialize database factory for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            // App Provider
            ChangeNotifierProvider(create: (context) => AppProvider()),

            // Mother Provider
            ChangeNotifierProvider(
              create: (context) => MotherProvider(
                motherRepository: MotherRepositoryImpl(
                  databaseHelper: DatabaseHelper(),
                ),
              ),
            ),

            // Baby Provider
            ChangeNotifierProvider(
              create: (context) => BabyProvider(
                babyRepository: BabyRepositoryImpl(
                  databaseHelper: DatabaseHelper(),
                ),
              ),
            ),

            // Recommendation Provider
            ChangeNotifierProvider(
              create: (context) => RecommendationProvider(
                recommendationRepository: RecommendationRepositoryImpl(
                  databaseHelper: DatabaseHelper(),
                ),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Baby Tracker',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6B73FF),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              fontFamily: 'SF Pro Display',
              appBarTheme: const AppBarTheme(
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black87,
              ),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
