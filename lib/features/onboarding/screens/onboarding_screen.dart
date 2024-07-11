import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/config/preference/preference_manager.dart';
import 'package:applematch/features/auth/screens/login_signup_screen.dart';
import 'package:applematch/features/onboarding/widgets/description_widget.dart';
import 'package:applematch/features/onboarding/widgets/onboarding1.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  static const String route = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingItems = [
    {
      "image": const Onboarding1(),
      "topic": "Find Your Perfect Match, \nOne Apple at a Time",
      "subtopic": "Gift Apples to show interest and find your \nmatch",
    },
    {
      "image": const Onboarding2(image: AppImages.onboarding2),
      "topic": "Introducing The Apple \nGenie",
      "subtopic":
          "Our Advanced AI for compatibility \ninsights during live chats and calls.",
    },
    {
      "image": const Onboarding3(),
      "topic": "Our First Date \nTradition",
      "subtopic": "Bring and Exchange an apple on your \nfirst date.",
    },
    {
      "image": const Onboarding2(image: AppImages.onboarding4),
      "topic": "Introducing Apple Bucket",
      "subtopic": "Each user begins with *100 apples* to \ngift wisely",
    },
    {
      "image": const Onboarding2(image: AppImages.onboarding5),
      "topic": "Apple Exchange",
      "subtopic":
          "Showing interest is as simple as sending an apple. if someone feels the same about you they send an apple back to *exchange*.",
    },
    {
      "image": const Onboarding2(image: AppImages.onboarding6),
      "topic": "Apple Rot",
      "subtopic":
          "Apples that have been gifted to another user will rot in *3 days* if not accepted."
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _goToNextPage() {
    if (_currentPage == onboardingItems.length - 1) {
       PreferenceManager.isFirstLaunch = false;
      Navigator.of(context).pushNamed(LoginSignupScreen.route);
    } else if (_currentPage < onboardingItems.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            _currentPage == 2 ? AppColors.onboardingPickBg : Colors.white,
      ),
    );
    return Scaffold(
      backgroundColor:
          _currentPage == 2 ? AppColors.onboardingPickBg : Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: PageView.builder(
                  itemCount: onboardingItems.length,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    final item = onboardingItems[index];
                    return item['image']!;
                  },
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, right: 49.w),
                    child: InkWell(
                      onTap: () {
                         PreferenceManager.isFirstLaunch = false;
                        Navigator.of(context)
                            .pushNamed(LoginSignupScreen.route);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.spMin,
                          color: const Color(0xFFD7D7D7),
                        ),
                      ),
                    ).topRight(),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.all(24.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: _currentPage == 2 ? Colors.white : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          onboardingItems[_currentPage]['topic']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.spMin,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black200,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Text(
                        //   onboardingItems[_currentPage]['subtopic']!,
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: 14.spMin,
                        //     color: AppColors.grey700,
                        //   ),
                        // ),
                        DescriptionWidget(
                          description: onboardingItems[_currentPage]
                              ['subtopic']!,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          width: 154.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 40),
                                color:
                                    const Color(0xFF0F0F0F).withOpacity(0.12),
                                blurRadius: 32,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: _goToPreviousPage,
                                child: Icon(
                                  FontAwesomeIcons.arrowLeftLong,
                                  color: _currentPage == 0
                                      ? AppColors.disabledGrey
                                      : AppColors.pink500,
                                  size: 24.spMin,
                                ),
                              ),
                              Container(
                                height: 24.h,
                                width: 2.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.r),
                                  color: const Color(0xFFE6E8EC),
                                ),
                              ),
                              InkWell(
                                onTap: _goToNextPage,
                                child: Icon(
                                  FontAwesomeIcons.arrowRightLong,
                                  color: AppColors.pink500,
                                  size: 24.spMin,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).center(),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
