import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/auth/screens/verification_container.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationScreen extends StatelessWidget {
  static const String route = '/verification';
  const VerificationScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
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

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39.w),
                      child: const VerificationContainer(),
                    ).center(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
