import 'dart:ui';
import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/payment/widgets/card_text_field.dart';
import 'package:applematch/mock/mock_users.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/drop_down_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icons/solar_icons.dart';

class EditProfileSCreen extends ConsumerStatefulWidget {
  static const String route = '/edit_profile';
  const EditProfileSCreen({super.key});

  @override
  ConsumerState<EditProfileSCreen> createState() => _EditProfileSCreenState();
}

class _EditProfileSCreenState extends ConsumerState<EditProfileSCreen> {
  final locations = ['Florida/USA', 'Washington/USA'];
  String region = 'Florida/USA';
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _bioController;
  late final TextEditingController _interestsController;
  late final TextEditingController _preferenceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _bioController = TextEditingController();
    _interestsController = TextEditingController();
    _preferenceController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _interestsController.dispose();
    _preferenceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ! get user detials from api with user id

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 70.h, left: 24.w, right: 24.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              // ! profile picture
                              ClipRRect(
                                borderRadius: BorderRadius.circular(99.9.r),
                                child: CachedNetworkImage(
                                  imageUrl: mockUsers[1].imageUrl!,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator
                                          .adaptive(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: 88.h,
                                  width: 88.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(99.9.r),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 8.0,
                                      sigmaY: 8.0,
                                    ),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 88.h,
                                width: 88.h,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(99.9.r),
                                  border: Border.all(color: AppColors.pink500),
                                ),
                              ),
                              Positioned(
                                bottom: 2.h,
                                right: 7.26.w,
                                child: Icon(
                                  SolarIconsBold.cameraMinimalistic,
                                  color: AppColors.pink500,
                                  size: 17.sp,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 36.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.pink500,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: SizedBox(
                              width: 182.w,
                              child: Text(
                                'View Exclusive Themes & Badges',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Column(
                          children: [
                            // ! username field
                            TextFieldSection(
                              controller: _nameController,
                              title: "Name",
                              enabledBorderColor: const Color(0xFFAFAFAF),
                              hintText: "First & Last name",
                              height: 48.h,
                              titleSize: 16.spMin,
                              titleWeight: FontWeight.w400,
                              titleColor: AppColors.black100,
                              borderRadius: 12.r,
                              widgetSpacing: 8.h,
                              capitalization: TextCapitalization.words,
                            ),
                            SizedBox(height: 16.h),

                            // ! email field
                            TextFieldSection(
                              controller: _emailController,
                              title: "Email",
                              enabledBorderColor: const Color(0xFFAFAFAF),
                              hintText: "New email address",
                              textType: TextInputType.emailAddress,
                              height: 48.h,
                              titleSize: 16.spMin,
                              titleWeight: FontWeight.w400,
                              titleColor: AppColors.black100,
                              borderRadius: 12.r,
                              widgetSpacing: 8.h,
                            ),
                            SizedBox(height: 16.h),

                            // ! date of birth
                            DropDownSection(
                              title: "Date of Birth",
                              items: locations,
                              value: region,
                              borderRadius: 12.r,
                              borderColor: const Color(0xFFAFAFAF),
                              buttonColor: AppColors.pink500,
                              width: double.maxFinite,
                              onChanged: (value) =>
                                  setState(() => region = value.toString()),
                            ),
                            SizedBox(height: 16.h),

                            // ! location dropdown
                            DropDownSection(
                              title: "Country/Region",
                              items: locations,
                              value: region,
                              borderRadius: 12.r,
                              borderColor: const Color(0xFFAFAFAF),
                              buttonColor: AppColors.pink500,
                              width: double.maxFinite,
                              onChanged: (value) =>
                                  setState(() => region = value.toString()),
                            ),
                            SizedBox(height: 16.h),

                            // ! bio field
                            TextFieldSection(
                              controller: _nameController,
                              title: "Bio",
                              enabledBorderColor: const Color(0xFFAFAFAF),
                              hintText: "Edit Your BIo",
                              height: 48.h,
                              titleSize: 16.spMin,
                              titleWeight: FontWeight.w400,
                              titleColor: AppColors.black100,
                              borderRadius: 12.r,
                              widgetSpacing: 8.h,
                            ),
                            SizedBox(height: 16.h),

                            // ! interests field
                            TextFieldSection(
                              controller: _nameController,
                              title: "Interests",
                              enabledBorderColor: const Color(0xFFAFAFAF),
                              hintText: "List Your Interests",
                              height: 48.h,
                              titleSize: 16.spMin,
                              titleWeight: FontWeight.w400,
                              titleColor: AppColors.black100,
                              borderRadius: 12.r,
                              widgetSpacing: 8.h,
                            ),
                            SizedBox(height: 16.h),

                            // ! preference field
                            TextFieldSection(
                              controller: _nameController,
                              title: "Preference",
                              enabledBorderColor: const Color(0xFFAFAFAF),
                              hintText: "State your Preference",
                              height: 48.h,
                              titleSize: 16.spMin,
                              titleWeight: FontWeight.w400,
                              titleColor: AppColors.black100,
                              borderRadius: 12.r,
                              widgetSpacing: 8.h,
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 2.h, bottom: 4.h),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: const AppBackButton(isCircular: true),
                        ),
                        SizedBox(
                          height: 50.h,
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.spMin,
                              color: AppColors.pink500,
                            ),
                          ).center(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
