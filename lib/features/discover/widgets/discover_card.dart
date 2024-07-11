import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverCard extends StatelessWidget {
  final User user;

  const DiscoverCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: user.imageUrl!,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 160.h,
                width: 105.w,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(top: 8.h, left: 7.5.w, child: newUser()),
            Positioned(
              bottom: 12.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 85.w),
                        child: Text(
                          "${user.username}, ${user.age}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      user.isVerified!
                          ? Row(
                              children: [
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.circle,
                                  color: AppColors.green300,
                                  size: 6.sp,
                                )
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Text(
                      "16 km away",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.spMin,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  newUser() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1, color: AppColors.purple100),
        color: AppColors.purple500,
      ),
      child: Text(
        "NEW",
        style: TextStyle(
          fontSize: 11.spMin,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
