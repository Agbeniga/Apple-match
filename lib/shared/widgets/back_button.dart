import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  final bool isCircular;
  final Color? color;

  const AppBackButton({
    super.key,
    this.isCircular = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(isCircular ? 999.9 : 12.r),
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 45.h,
        height: 45.h,
        decoration: BoxDecoration(
          color: color != null
              ? Colors.transparent
              : Colors.white.withOpacity(0.67),
          borderRadius: BorderRadius.circular(isCircular ? 999.r : 12.r),
          border: isCircular && color != null
              ? Border.all(color: color!.withOpacity(0.08))
              : isCircular && color == null
                  ? Border.all(
                      color: AppColors.black100.withOpacity(0.08),
                    )
                  : null,
          boxShadow: isCircular
              ? null
              : [
                  BoxShadow(
                    offset: const Offset(5.92, 11.84),
                    blurRadius: 23.68,
                    color: AppColors.grey300.withOpacity(0.3),
                  )
                ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18.spMin,
          weight: 2.37,
          color: color ?? Colors.black, // Use null check operator here
        ),
      ),
    );
  }
}
