import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isOutline;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final VoidCallback? onTap;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.isOutline = false,
    this.fontSize,
    this.height,
    this.width,
    this.color,
    this.textColor,
    this.borderRadius,
    this.fontWeight,
    this.onTap, this.isLoading =false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutline) {
      return InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        onTap: isLoading ?   null : onTap,
        child: isLoading? CircularProgressIndicator() : Ink(
          width: width ?? double.infinity,
          height: height ?? 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            color: color ?? Colors.white,
            border: Border.all(color: AppColors.pink500),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? (AppColors.pink500),
              fontWeight: fontWeight ?? FontWeight.w600,
              fontSize: fontSize ?? 16.spMin,
            ),
          ).center().animate().fadeIn(),
        ),
      );
    } else {
      return InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
    onTap: isLoading ?   null : onTap,
        child: Container(
          alignment: Alignment.center,
          width: width ?? double.infinity,
          height: height ?? 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            color: color ?? AppColors.pink500,
          ),
          child:  isLoading? CircularProgressIndicator(color: Colors.white,) :Text(
            text,
            style: TextStyle(
              color: textColor ?? (Colors.white),
              fontWeight: fontWeight ?? FontWeight.w600,
              fontSize: fontSize ?? 16.spMin,
            ),
          ).animate().fadeIn(),
        ),
      );
    }
  }
}
