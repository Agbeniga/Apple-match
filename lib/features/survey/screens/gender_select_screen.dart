import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/survey/providers/gender_provider.dart';
import 'package:applematch/features/survey/screens/looking_for_screen.dart';
import 'package:applematch/features/survey/widgets/gender_button.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelectScreen extends ConsumerWidget {
  static const route = "/gender-select";
  const GenderSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(genderProvider);

    return Scaffold(
      body: Stack(
        children: [
          // ! body
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 66.h, left: 16.w, right: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "What’s Your Gender",
                    style: TextStyle(
                      color: AppColors.pink500,
                      fontSize: 32.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    "Tell us about your gender",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey700,
                      fontSize: 17.spMin,
                    ),
                  ),
                  SizedBox(height: 139.h),
                ],
              ),
            ).top(),
          ),

          // ! gender buttons
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GenderButton(
                onTap: () {
                  ref.read(genderProvider.notifier).state = Genders.male;
                  print(selectedGender);
                },
                gender: Genders.male,
                selectedGender: selectedGender,
              ),
              SizedBox(height: 48.h),
              GenderButton(
                onTap: () {
                  ref.read(genderProvider.notifier).state = Genders.female;
                  print(selectedGender);
                },
                gender: Genders.female,
                selectedGender: selectedGender,
              )
            ],
          ).center(),

          // ! continue button
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: const SafeArea(child: AppBackButton(isCircular: true)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
            child: SafeArea(
              top: false,
              child: PrimaryButton(
                text: "Continue",
                borderRadius: 50.r,
                onTap: () {
                  Navigator.pushNamed(context, LookingForScreen.route);
                },
              ).bottom(),
            ),
          ),
        ],
      ),
    );
  }
}
