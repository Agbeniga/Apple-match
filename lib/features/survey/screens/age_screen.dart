import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/survey/screens/gender_select_screen.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AgeScreen extends ConsumerWidget {
  static const String route = '/age-screen';
  const AgeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAge = ref.watch(selectedAgeProvider);
    List<int> ageRange = List<int>.generate(100, (index) => index + 1);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFD9D9D9).withOpacity(0.0),
                  const Color(0xFFFFDEE9),
                  const Color(0xFFFFDEE9).withOpacity(0.2),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 64.h, left: 16.w, right: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "How Old Are You?r",
                    style: TextStyle(
                      color: AppColors.pink500,
                      fontSize: 32.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    "Please provide your age in years",
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

          // ! back button
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: const SafeArea(child: AppBackButton(isCircular: true)),
          ),

          // ! continue button
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
            child: SafeArea(
              top: false,
              child: PrimaryButton(
                text: "Continue",
                borderRadius: 50.r,
                onTap: () {
                  Navigator.pushNamed(context, GenderSelectScreen.route);
                },
              ).bottom(),
            ),
          ),

          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 150.h),
              child: Stack(
                children: [
                  CupertinoPicker(
                    squeeze: 1.1,
                    diameterRatio: 1.5,
                    selectionOverlay: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 131.w, vertical: 0.h),
                      constraints: BoxConstraints(maxWidth: 300.w),
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            width: 3,
                            color: AppColors.pink500,
                          ),
                        ),
                      ),
                    ),
                    useMagnifier: false,
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedAge - 1),
                    itemExtent: 100.h,
                    onSelectedItemChanged: (int index) {
                      ref.read(selectedAgeProvider.notifier).state =
                          ageRange[index];
                    },
                    children: ageRange
                        .map(
                          (age) => Center(
                            child: Text(
                              age.toString(),
                              style: GoogleFonts.inter(
                                color: selectedAge == age
                                    ? AppColors.pink500
                                    : Colors.black,
                                fontSize:
                                    selectedAge == age ? 64.spMin : 48.spMin,
                                fontWeight: selectedAge == age
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final selectedAgeProvider = StateProvider<int>((_) => 32);
