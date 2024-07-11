import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/constants/constants.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/features/auth/screens/login_signup_screen.dart';
import 'package:applematch/features/bot/screens/apple_genie_screen.dart';
import 'package:applematch/features/genie_onboarding/model/onboarding_item.dart';
import 'package:applematch/features/genie_onboarding/widgets/description_texts.dart';
import 'package:applematch/features/genie_onboarding/widgets/selection_button.dart';
import 'package:applematch/features/payment/widgets/card_text_field.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/horizontal_list.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenieOnboardingScreen extends StatefulWidget {
  static const String route = '/genie_onboarding';
  const GenieOnboardingScreen({super.key});

  @override
  State<GenieOnboardingScreen> createState() => _GenieOnboardingScreenState();
}

class _GenieOnboardingScreenState extends State<GenieOnboardingScreen> {
  late final PageController _controller;
  final TextEditingController _perfectWeekendController =
      TextEditingController();
  final TextEditingController _favoriteCuisineController =
      TextEditingController();
  final TextEditingController _favoriteMovieController =
      TextEditingController();
  final TextEditingController _partnerQualityController =
      TextEditingController();
  final TextEditingController _perfectDateController = TextEditingController();
  final TextEditingController _relationshipGoalsController =
      TextEditingController();
  final TextEditingController _freeTimeController = TextEditingController();
  final TextEditingController _coreValuesController = TextEditingController();
  final TextEditingController _famousPersonController = TextEditingController();
  final TextEditingController _adventurousThingController =
      TextEditingController();
  final TextEditingController _fruitController = TextEditingController();
  final TextEditingController _travelDestinationController =
      TextEditingController();
  final TextEditingController _professionalAspirationsController =
      TextEditingController();
  final TextEditingController _learnController = TextEditingController();
  int _currentPage = 0;

  List<OnboardingItem> onboardingItems() => [
        OnboardingItem(
          image: AppImages.genieOnboarding1,
          topic: "Welcome to Apple Genie",
          subtopic: const DescriptionTexts(
            text:
                "Our Advanced Ai is here to ask you some fun and thoughtful questions. This helps us get to know your unique personality and preferences for the perfect match. Lets dive in and discover your ideal partner together!",
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding2,
          topic: "Select your Interests & Hobbies",
          category: "Basic Information",
          categoryIndex: 1,
          subtopic: HorizontalListWithTwoColumns(
            height: 115.h,
            children: interestsConstants,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding3,
          topic: "Describe your perfect Weekend",
          category: "Basic Information",
          categoryIndex: 2,
          subtopic: TextFieldSection(
            controller: _perfectWeekendController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Describe your perfect Weekend",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding4,
          topic: "What’s your favorite type of Cuisine?",
          category: "Basic Information",
          categoryIndex: 3,
          subtopic: TextFieldSection(
            controller: _favoriteCuisineController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Describe your favorite type of Cuisine",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding5,
          topic: "Are you more of an Introvert or Extrovert?",
          category: "Personality & Preferences",
          categoryIndex: 1,
          subtopic: const SelectionButton(
            options: ["Introvert", "Extrovert"],
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding6,
          topic: "Do you Prefer the Beach or Mountains?",
          category: "Personality & Preferences",
          categoryIndex: 2,
          subtopic: const SelectionButton(
            options: ["Beach", "Mountains"],
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding8,
          topic: "What’s your favorite movie or TV Show?",
          category: "Personality & Preferences",
          categoryIndex: 3,
          subtopic: TextFieldSection(
            controller: _favoriteMovieController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Your favorite movie or TV show",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding9,
          topic: "What qualities do you look for in a partner?",
          category: "Relationship Goals",
          categoryIndex: 1,
          subtopic: TextFieldSection(
            controller: _partnerQualityController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Enter Your desired partner qualities",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding10,
          topic: "What’s your idea of a perfect date?",
          category: "Relationship Goals",
          categoryIndex: 2,
          subtopic: TextFieldSection(
            controller: _perfectDateController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Enter Your Idea of a perfect date",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding11,
          topic: "What are your long-term relationship goals?",
          category: "Relationship Goals",
          categoryIndex: 3,
          subtopic: TextFieldSection(
            controller: _relationshipGoalsController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Enter Your long-term relationship goals",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding2,
          topic: "How do you like to spend your free time",
          category: "Lifestyle & Values",
          categoryIndex: 1,
          subtopic: TextFieldSection(
            controller: _freeTimeController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding12,
          topic: "What are your core Values?",
          category: "Lifestyle & Values",
          categoryIndex: 2,
          subtopic: TextFieldSection(
            controller: _coreValuesController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Core values",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding13,
          topic: "How important is fitness & Health to you?",
          category: "Lifestyle & Values",
          categoryIndex: 3,
          subtopic: const SelectionButton(
            options: ["Not Important", "Fairly Important", "Very Important"],
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding14,
          topic:
              "If you could have dinner with any famous person, who would it be & Why?",
          category: "Fun & Quirky",
          categoryIndex: 1,
          subtopic: TextFieldSection(
            controller: _famousPersonController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Enter the famous person’s name & why",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding3,
          topic: "What’s the most adventurous thing you have ever done?",
          category: "Fun & Quirky",
          categoryIndex: 2,
          subtopic: TextFieldSection(
            controller: _adventurousThingController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Enter the most adventurous thing you did",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding15,
          topic: "If you were a fruit, which one would you be and why?",
          category: "Fun & Quirky",
          categoryIndex: 3,
          subtopic: TextFieldSection(
            controller: _fruitController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Enter the Fruit you would be & why",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding16,
          topic: "What’s your dream travel destination?",
          category: "Dreams & Aspirations",
          categoryIndex: 1,
          subtopic: TextFieldSection(
            controller: _travelDestinationController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Dream travel",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding17,
          topic: "What are your professional aspirations?",
          category: "Dreams & Aspirations",
          categoryIndex: 2,
          subtopic: TextFieldSection(
            controller: _professionalAspirationsController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "Professional aspirations",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding18,
          topic: "What’s one thing you’ve always wanted to learn or try?",
          category: "Dreams & Aspirations",
          categoryIndex: 3,
          subtopic: TextFieldSection(
            controller: _learnController,
            title: "",
            enabledBorderColor: Colors.black,
            hintText: "",
            height: 65.h,
            titleSize: 16.spMin,
            titleWeight: FontWeight.w400,
            titleColor: AppColors.black100,
            borderRadius: 12.r,
            widgetSpacing: 8.h,
            isLast: true,
          ),
        ),
        OnboardingItem(
          image: AppImages.genieOnboarding1,
          topic: "Thank You!",
          subtopic: const DescriptionTexts(
            text:
                "Thank you for taking the time to tell us more about you, your responses help us tailor the experience to your unique personalities and survey. We are excited to help you find your perfect match. one apple at a time",
          ),
        ),
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

    _perfectWeekendController.dispose();
    _favoriteCuisineController.dispose();
    _perfectWeekendController.dispose();
    _favoriteCuisineController.dispose();
    _favoriteMovieController.dispose();
    _partnerQualityController.dispose();
    _perfectDateController.dispose();
    _relationshipGoalsController.dispose();
    _freeTimeController.dispose();
    _coreValuesController.dispose();
    _famousPersonController.dispose();
    _adventurousThingController.dispose();
    _fruitController.dispose();
    _travelDestinationController.dispose();
    _professionalAspirationsController.dispose();
    _learnController.dispose();
  }

  void _goToNextPage() {
    if (_currentPage == onboardingItems().length - 1) {
      Navigator.of(context).pushNamed(LoginSignupScreen.route);
    } else if (_currentPage < onboardingItems().length - 1) {
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
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Visibility(
                visible: onboardingItems()[_currentPage].category != null,
                child: SizedBox(
                  width: 200.w,
                  child: Row(
                    children: [
                      for (int i = 1; i <= 3; i++)
                        _buildCategoryIndicator(onboardingItems(), i),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: onboardingItems()[_currentPage].category != null,
                child: Text(
                  "${onboardingItems()[_currentPage].category}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.spMin,
                    fontWeight: FontWeight.w600,
                    color: AppColors.pink500,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: onboardingItems().length,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    final item = onboardingItems()[index];
                    return Image.asset(item.image);
                  },
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(24.h),
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      onboardingItems()[_currentPage].topic,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.spMin,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black200,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    onboardingItems()[_currentPage].subtopic,
                    SizedBox(
                      height: 30.h,
                    ),
                    _currentPage == 19
                        ? PrimaryButton(
                            text: "Confirm",
                            height: 55.h,
                            onTap: () {
                              Navigator.of(context).pushNamed(AppleGenieScreen.route);
                            },
                          )
                        : Container(
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
        ),
      ),
    );
  }

  Widget _buildCategoryIndicator(List<OnboardingItem> items, int index) {
    final isCompleted = items[_currentPage].categoryIndex != null &&
        items[_currentPage].categoryIndex! > index;
    final isActive = items[_currentPage].categoryIndex == index;

    return Row(
      children: [
        Container(
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.pink500),
            color: isActive ? AppColors.pink500 : Colors.white,
          ),
          child: isCompleted
              ? const Center(
                  child: Icon(
                    Icons.check,
                    color: AppColors.pink500,
                    size: 18,
                  ),
                )
              : Center(
                  child: Text(
                    "$index",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isActive ? Colors.white : AppColors.pink500,
                    ),
                  ),
                ),
        ),
        if (index < 3)
          SizedBox(width: 51.w, child: const Divider(color: AppColors.pink500)),
      ],
    );
  }
}
