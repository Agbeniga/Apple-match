import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionTexts extends StatelessWidget {
  final String text;
  const DescriptionTexts({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14.spMin,
        color: AppColors.grey700,
      ),
    );
  }
}
