import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAuthButton extends StatelessWidget {
 
  final VoidCallback? onTap;
  final String text, icon;


  const CustomAuthButton({
    super.key,
    this.onTap, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          // color: Colors.white,
          border: Border.all(color: AppColors.grey100),
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.spMin,
                color: AppColors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
