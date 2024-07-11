import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppleNotificationTile extends StatelessWidget {
  final User user;

  const AppleNotificationTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.spMin),
      width: double.maxFinite,
      child: Row(
        children: [
          SizedBox(
            width: 73.w,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(99.9.r),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 60.h,
                    width: 60.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 2.h,
                  right: 0.w,
                  child: appleNumber(30),
                )
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username!,
                style: TextStyle(
                  fontSize: 16.spMin,
                  color: AppColors.black100,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // TODO: number of hours remaining for the apple to expire
              Text(
                '15 hours remaining',
                style: TextStyle(
                  fontSize: 15.spMin,
                  color: AppColors.grey700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          PrimaryButton(
            text: "Accept",
            width: 89.w,
            height: 34.h,
          )
        ],
      ),
    );
  }

  appleNumber(int noOfApples) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppImages.appleNumber,
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 9.h),
          child: Text(
            '$noOfApples',
            style: TextStyle(
              fontSize: 20.spMin,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
