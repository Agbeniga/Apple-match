import 'package:applematch/features/survey/screens/photo_verification_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImage extends StatelessWidget {
  final VoidCallback onTap;

  const AddImage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, PhotoVerificationScreen.route),
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [4, 4],
        color: const Color(0xFFFF5069),
        radius: Radius.circular(16.r),
        child: Container(
          height: 100.h,
          width: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 16.15.w,
                right: 16.15.w,
                child: Icon(
                  Icons.add_circle_rounded,
                  size: 39.spMin,
                  color: const Color(0xFFFF5069),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
