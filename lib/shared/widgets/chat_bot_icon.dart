import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/features/bot/screens/apple_genie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatBotIcon extends StatelessWidget {
  const ChatBotIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppleGenieScreen.route),
      child: Container(
        width: 71.w,
        height: 56.h,
        padding: EdgeInsets.fromLTRB(14.5.w, 8.h, 16.5.w, 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(color: AppColors.purple100, width: 1.5),
          color: AppColors.purple500.withOpacity(0.9),
        ),
        child: Container(
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            border: Border.all(
              color: AppColors.purple100.withOpacity(0.3),
              width: 3,
            ),
            color: AppColors.purple500.withOpacity(0.9),
          ),
          child: SvgPicture.asset(AppIcons.jasperAi),
        ),
      ),
    );
  }
}
