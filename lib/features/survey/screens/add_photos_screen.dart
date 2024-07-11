import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/utils/utils.dart';
import 'package:applematch/features/survey/providers/photo_provider.dart';
import 'package:applematch/features/survey/screens/age_screen.dart';
import 'package:applematch/features/survey/screens/photo_verification_screen.dart';
import 'package:applematch/features/survey/widgets/add_image.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPhotoScreen extends ConsumerStatefulWidget {
  static const String route = '/add-photo';
  const AddPhotoScreen({super.key});

  @override
  ConsumerState<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends ConsumerState<AddPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final images = ref.watch(takePhotoProvider);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
           Color(0xFFD9D9D9).withOpacity(0.0),
      ),
    );
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

          // ! body
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 66.h),
              child: Column(
                children: [
                  Text(
                    "Add your first 3 photos",
                    style: TextStyle(
                      color: AppColors.pink500,
                      fontSize: 32.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    "We'd love to see you. Upload a photo \nfor your dating journey.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey700,
                      fontSize: 20.spMin,
                    ),
                  ),
                ],
              ),
            ).center(),
          ),
          if (images.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) => AddImage(onTap: () {}),
                ),
              ),
            ).center()
          else if (images.length == 1)
            InkWell(
               onTap: () => Navigator.pushNamed(context, PhotoVerificationScreen.route),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.file(
                        images[0],
                        fit: BoxFit.cover,
                        width: 235.w,
                        height: 246.h,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AddImage(onTap: () {}),
                        SizedBox(height: 32.h),
                        AddImage(onTap: () {})
                      ],
                    )
                  ],
                ),
              ).center(),
            )
          else if (images.length == 2)
            SizedBox(
              height: 246.h,
              width: double.maxFinite,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18.5.w),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  if (index == 2) {
                    return AddImage(onTap: () {}).center();
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 26.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.file(
                        images[index],
                        fit: BoxFit.cover,
                        width: 235.w,
                        height: 246.h,
                      ),
                    ),
                  );
                },
              ),
            ).center()
          else
            SizedBox(
              height: 246.h,
              width: double.maxFinite,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18.5.w),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 26.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.file(
                        images[index],
                        fit: BoxFit.cover,
                        width: 235.w,
                        height: 246.h,
                      ),
                    ),
                  );
                },
              ),
            ).center(),
          Padding(
            padding: EdgeInsets.only(left: 24.w, top: 20.h),
            child: const SafeArea(child: AppBackButton(isCircular: true)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
            child: SafeArea(
              top: false,
              child: PrimaryButton(
                onTap: () async {
                if(images.isEmpty){
                  showError(context: context, text: "Take a photo");
                  return;
                }
                  // temporary
                  Navigator.pushNamed(context, AgeScreen.route);
                },
                text: "Continue",
              ).bottom(),
            ),
          ),
        
        ],
      ),
    );
  }
}
