import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRoundedInfoContainer extends StatelessWidget {
  final Widget leading;
  final String? text;

  const AppRoundedInfoContainer({
    super.key,
    required this.leading,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: text != null ? EdgeInsets.fromLTRB(14.5.w, 8.h, 22.5, 8.h) : EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: AppColors.purple100, width: 1.5),
        color: AppColors.purple500.withOpacity(0.9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          Visibility(visible: text != null, child: SizedBox(width: 12.w)),
          Visibility(
            visible: text != null,
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 20.spMin,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    ).animate().flip();
  }
}
