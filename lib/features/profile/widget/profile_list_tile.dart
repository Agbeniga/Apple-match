import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final double? itemSpacing;
  final double? bottomPadding;
  final Color? color;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileListTile({
    super.key,
    required this.leading,
    required this.title,
    this.itemSpacing,
    this.color,
    this.trailing,
    this.onTap,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 12.h),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          child: Row(
            children: [
              leading,
              SizedBox(width: itemSpacing ?? 12.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w500,
                  color: color ?? AppColors.black100,
                ),
              ),
              const Spacer(),
              trailing ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}
