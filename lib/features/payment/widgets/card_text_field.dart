import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/constants/card_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldSection extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool isCard;
  final Widget? icon;
  final double? borderRadius;
  final Color? focusBorderColor;
  final Color? enabledBorderColor;
  final Color? hintColor;
  final double? titleSize;
  final Color? titleColor;
  final double height;
  final FontWeight? titleWeight;
  final double widgetSpacing;
  final TextInputType? textType;
  final TextCapitalization? capitalization;
  final bool isLast;
  final FocusNode? focusNode;

  const TextFieldSection({
    super.key,
    required this.controller,
    required this.title,
    this.isCard = false,
    this.icon,
    this.hintText = '',
    this.borderRadius,
    this.focusBorderColor,
    this.enabledBorderColor,
    this.hintColor,
    this.titleColor,
    this.titleSize,
    this.height = 56,
    this.titleWeight,
    this.widgetSpacing = 9,
    this.capitalization,
    this.textType,
    this.isLast = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize ?? 14.spMin,
            fontWeight: titleWeight ?? FontWeight.w600,
            color: titleColor ?? AppColors.black300,
          ),
        ),
        SizedBox(height: widgetSpacing.h),
        SizedBox(
          height: height.h,
          child: TextFormField(
            focusNode: focusNode,
            cursorColor: AppColors.pink500,
            style: TextStyle(
              fontSize: 14.spMin,
              letterSpacing: isCard ? 2 : null,
              fontWeight: FontWeight.w500,
              color: AppColors.black300,
            ),
            onEditingComplete: () {
              if (!isLast) {
                FocusScope.of(context).nextFocus();
              } else {
                FocusScope.of(context).unfocus();
              }
            },
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: isCard
                ? [
                    LengthLimitingTextInputFormatter(20),
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberInputFormatter(),
                  ]
                : null,
            keyboardType: textType ??
                (isCard ? TextInputType.number : TextInputType.text),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal: 16.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                borderSide: BorderSide(
                  color: enabledBorderColor ?? AppColors.black300,
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                borderSide: BorderSide(
                  color: enabledBorderColor ?? AppColors.black300,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                borderSide: BorderSide(
                  color: focusBorderColor ?? AppColors.black300,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.spMin,
                fontWeight: FontWeight.w500,
                color: AppColors.grey700,
              ),
              suffixIcon: icon,
            ),
          ),
        ),
      ],
    );
  }
}
