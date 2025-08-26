import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/mother_provider.dart';
import '../providers/baby_provider.dart';
import 'onboarding/welcome_screen.dart';
import 'dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule initialization after the current build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    try {
      final appProvider = context.read<AppProvider>();
      final motherProvider = context.read<MotherProvider>();
      final babyProvider = context.read<BabyProvider>();

      // Initialize app first
      await appProvider.initializeApp();

      // Check if it's not first time
      if (!appProvider.isFirstTime) {
        final motherExists = await motherProvider.checkMotherExists();
        if (motherExists && motherProvider.mother != null) {
          await babyProvider.loadBaby(motherProvider.mother!.id);
        }
      }

      // Add a minimum delay for splash screen visibility
      await Future.delayed(const Duration(milliseconds: 2000));

      if (!mounted) return;

      // Navigate based on app state
      if (appProvider.isFirstTime || !motherProvider.hasMother) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } catch (e) {
      // Handle errors gracefully
      if (!mounted) return;

      // In case of error, go to welcome screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B73FF),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.child_care, size: 80, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Baby Tracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bebeğinizin gelişimini takip edin',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
