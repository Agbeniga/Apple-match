import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/auth/screens/login_screen.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyEmailScreen extends StatelessWidget {
  static const String route = '/verify_email';
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: AppColors.pink50),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              // ! Back Button
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0.w),
                    child:
                        const AppBackButton().animate(delay: 150.ms).flip(),
                  )),
        SizedBox(height: 100.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 39.w),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 40.h,
                    bottom: 42.h,
                    left: 17.5,
                    right: 17.5,
                  ),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27.r),
                    color: const Color(0xFFF7F8FA),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 13.32),
                        blurRadius: 55.48,
                        color: AppColors.purple600.withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Verify your Email",
                        style: TextStyle(
                          fontSize: 22.spMin,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pink500,
                        ),
                      ),
                      SizedBox(height: 11.h),
                      Text(
                        "We have sent an email to mx@gmail.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.spMin,
                          color: AppColors.grey500,
                        ),
                      ).center(),
                      Text(
                        "You need to  verify email to continue. If you have not received the verification email, please check your “Spam” or “Bulk Email” folder. You can also click the resend button below to  have another email sent to you.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.spMin,
                          color: AppColors.grey500,
                        ),
                      ).center(),
                       SizedBox(height: 30.h,),
                          PrimaryButton(
                            text: "Continue",
                            height: 68.21.h,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, LoginScreen.route);
                            },
                          ),
                          const SizedBox(height: 12.4),
                          PrimaryButton(
                            text: "Resend Verification Email",
                            color: AppColors.grey50,
                            textColor: AppColors.grey600,
                            height: 68.21.h,
                            onTap: () async {},
                          ),
                      
                    ],
                  ),
                ),
              ).center(),
            ],
          ),
        ),
      ),
    );
  }
}
