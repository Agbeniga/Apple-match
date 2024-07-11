import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InterestsContainer extends StatelessWidget {
  final String text;
  final double? bottomPadding;
  final bool? isSelected;
  final VoidCallback? onTap;
  final bool isSingleSelect;

  const InterestsContainer({
    super.key,
    required this.text,
    this.bottomPadding,
    this.isSelected,
    this.onTap,
    this.isSingleSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(32.r);
    final containerColor = _getContainerColor();
    final borderColor = _getBorderColor();
    final textColor = _getTextColor();

    return Padding(
      padding: EdgeInsets.only(right: 18.w, bottom: bottomPadding ?? 20.h),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: isSingleSelect
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: containerColor,
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              )
            : Ink(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: containerColor,
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
      ),
    );
  }

  Color? _getContainerColor() {
    if (isSelected == null) return null;
    if (isSingleSelect && isSelected!) return AppColors.pink500;
    if (isSelected!) return AppColors.purple500.withOpacity(0.2);
    return Colors.white;
  }

  Color _getBorderColor() {
    if (isSelected != null) {
      if (isSingleSelect && isSelected!) return Colors.white;
      return AppColors.purple500.withOpacity(0.2);
    }
    return AppColors.purple500.withOpacity(0.2);
  }

  Color _getTextColor() {
    if (isSelected != null) {
      if (isSingleSelect && isSelected!) return Colors.white;
      return AppColors.purple500;
    }
    return AppColors.purple500;
  }
}
