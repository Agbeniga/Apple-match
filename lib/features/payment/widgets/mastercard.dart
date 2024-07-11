import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MasterCard extends StatelessWidget {
  const MasterCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: fix the icons not showing
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(0, 14),
          child: Container(
            width: 344.w,
            height: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.black300.withOpacity(0.51),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 20),
                  blurRadius: 30,
                  color: Colors.white.withOpacity(0.15),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20.w, 30.h, 30.w, 18.h),
          width: 344.w,
          height: 178.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.purple500,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppIcons.card),
                  SvgPicture.asset(AppIcons.moreHoriz)
                ],
              ),
              SizedBox(height: 16.5.h),
              Text(
                "5698    56254    6786    9979",
                style: TextStyle(
                  fontSize: 15.spMin,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cad Holder",
                        style: TextStyle(
                          fontSize: 12.spMin,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Name Here",
                        style: TextStyle(
                          fontSize: 17.spMin,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    AppImages.mastercard,
                    height: 42.h,
                    width: 42.w,
                    fit: BoxFit.fitWidth,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
