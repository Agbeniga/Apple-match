import 'package:applematch/config/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Image.asset(
            AppImages.onboarding1,
          ),
        ),
      ],
    );
  }
}

class Onboarding2 extends StatelessWidget {
  final String image;

  const Onboarding2(
      {super.key,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(height: 70.h,),
        Center(
          child: Container(
            width: 336.w,
            height: 438.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(0, 2),
                  color: Color(0xff817E77),
                  spreadRadius: -10,
                  blurRadius: 50,
                ),
                BoxShadow(
                  offset: Offset(0, -2),
                  color: Color(0xff817E77),
                  spreadRadius: -10,
                  blurRadius: 50,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                image,
                width: 336.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(height: 50.h,),
        Image.asset(
          AppImages.onboarding3,
          height: 400.h,
        ),
      ],
    );
  }
}
