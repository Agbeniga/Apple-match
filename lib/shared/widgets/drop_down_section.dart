import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/payment/widgets/app_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownSection extends StatelessWidget {
  final String title;
  final List items;
  final Object value;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final double? titleSize;
  final Color? titleColor;
  final Color? buttonColor;
  final double height;
  final FontWeight? titleWeight;
  final void Function(Object?)? onChanged;

  const DropDownSection({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.onChanged,
    this.buttonColor,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.titleColor,
    this.titleSize,
    this.height = 48,
    this.titleWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize ?? 16.spMin,
            fontWeight: titleWeight ?? FontWeight.w400,
            color: titleColor ?? AppColors.black100,
          ),
        ),
        SizedBox(height: 8.h),
        AppDropDownButton(
          items: items,
          stateValue: value,
          onChanged: onChanged,
          borderColor: borderColor,
          borderRadius: borderRadius,
          height: 48.h,
          width: width,
          buttonColor: buttonColor,
          textWeight: FontWeight.w400,
          textColor: AppColors.grey700,
        )
      ],
    );
  }
}
