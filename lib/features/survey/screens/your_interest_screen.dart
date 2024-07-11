import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/constants/constants.dart';
import 'package:applematch/features/survey/providers/interests_provider.dart';
import 'package:applematch/features/survey/screens/add_photos_screen.dart';
import 'package:applematch/features/survey/widgets/interests_container.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourInterestScreen extends ConsumerWidget {
  static const String route = '/your-interests';
  final bool showBackButton;
  const YourInterestScreen( {super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
           Colors.white,
      ),
    );
    final interests = ref.watch(interestsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: showBackButton,
                      child: Padding(
                        
                        padding: EdgeInsets.only(top: 10.h),
                        child: AppBackButton(isCircular: true)),
                    ),
                    Text(
                      "Your Interests",
                      style: TextStyle(
                        color: AppColors.pink500,
                        fontWeight: FontWeight.w500,
                        fontSize: 32.spMin,
                      ),
                    ),
                SizedBox(height: 10.h),
                Text(
                  "Select a few of your interests and let everyone know what you’re passionate about.",
                  style: TextStyle(
                    fontSize: 14.spMin,
                    color: AppColors.grey700,
                  ),
                ),
                SizedBox(height: 20.h),
                
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: List.generate(
                      interestsConstants.length,
                      (index) {
                        final interest = interestsConstants[index];
                        final isSelected = interests.contains(interest);
                        return InterestsContainer(
                          isSelected: isSelected,
                          text: interest,
                          onTap: () {
                            final currentInterests =
                                ref.read(interestsProvider.notifier).state;
                  
                            if (isSelected) {
                              currentInterests.remove(interest);
                            } else {
                              currentInterests.add(interest);
                            }
                            ref.read(interestsProvider.notifier).state =
                                List.from(currentInterests);
                          },
                        );
                      },
                    ).animate(interval: 100.ms).fade(
                          duration: 50.ms,
                          curve: Curves.bounceIn,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.w,
                ),
                child: SafeArea(
                  top: false,
                  child: PrimaryButton(
                    onTap: () {
                      Navigator.pushNamed(context, AddPhotoScreen.route);
                    },
                    text: "Confirm",
                  ).bottom(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
