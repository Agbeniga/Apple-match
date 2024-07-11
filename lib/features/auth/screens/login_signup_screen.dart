import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/preference/preference_manager.dart';
import 'package:applematch/features/auth/providers/auth_provider.dart';
import 'package:applematch/features/auth/screens/login_screen.dart';
import 'package:applematch/features/auth/screens/signup_screen.dart';
import 'package:applematch/features/auth/widgets/third_party_auth_button.dart';
import 'package:applematch/features/survey/screens/your_interest_screen.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSignupScreen extends ConsumerWidget {
  static const String route = "login-signup";
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );
    final _auth = ref.watch(authenticationProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 52.h),
          child: SingleChildScrollView(
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "Apple Match",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 44.spMin,
                          color: AppColors.pink500,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -44.h),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 219.h,
                          width: 199.w,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      top: 46.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryButton(
                            onTap: () {
                              Navigator.pushNamed(context, LoginScreen.route);
                            },
                            text: "Log In"),
                        SizedBox(height: 40.h),
                        PrimaryButton(
                          onTap: () {
                             Navigator.pushNamed(context, SignupScreen.route);
                          },
                          text: "Sign Up",
                          isOutline: true,
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.grey200,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                "Or",
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  color: AppColors.grey700,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: AppColors.grey200,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40.h),
                        CustomAuthButton(
                          text: "Continue with Google",
                          icon: AppIcons.google,
                          onTap: () async {
                            await _auth.signInWithGoogle(context).then((result) {
                              if (result == null) {
                                return;
                              } else {
                                PreferenceManager.accessToken =
                                    result.credential?.accessToken ?? "";
              
                                Navigator.of(context)
                                    .pushNamed(YourInterestScreen.route);
                              }
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustomAuthButton(
                          text: "Continue with Facebook",
                          icon: AppIcons.facebook,
                          onTap: () async {
                            await _auth.signInWithFacebook(context).then((result) {
                              if (result == null) {
                                return;
                              } else {
                                print(result.credential?.asMap());
                                Navigator.of(context)
                                    .pushNamed(YourInterestScreen.route);
                              }
                            });
              
                          
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
