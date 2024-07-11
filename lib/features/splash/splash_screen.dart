import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/preference/preference_manager.dart';
import 'package:applematch/features/auth/providers/auth_provider.dart';
import 'package:applematch/features/auth/screens/login_screen.dart';
import 'package:applematch/features/home/screens/home_screen.dart';
import 'package:applematch/features/onboarding/screens/onboarding_screen.dart';
import 'package:applematch/features/survey/screens/your_interest_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String route = "/spalsh_screen";
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, (){
    //    Navigator.of(context).pushReplacementNamed(OnboardingScreen.route);
    // });
      _navigateToNextScreen();
  }

void _navigateToNextScreen() async {
    try {
      final userData = await ref.read(userDataAuthProvider.future);
      if (userData != null) {
        if (PreferenceManager.isRegistered) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.route);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const YourInterestScreen(showBackButton: false),
            ),
          );
        }
      } else {
        if (PreferenceManager.isFirstLaunch) {
          Navigator.of(context).pushReplacementNamed(OnboardingScreen.route);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(showBackButton: false),
            ),
          );
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(showBackButton: false),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Transform.translate(
                offset: Offset(0, -44.h),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 219,
                  width: 199,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Apple Match",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 44.spMin,
                    color: AppColors.pink500,
                  ),
                ),
                Text(
                  "How Do You Like Them Apples",
                  style:
                      TextStyle(fontSize: 14.spMin, color: AppColors.grey700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
