import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/matches/widgets/shimmer_match_widget.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const MatchCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: CachedNetworkImage(
              imageUrl: user.imageUrl!,
              placeholder: (context, url) =>
                  const ShimmerMatchWidget().shimmerContainer(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
              height: 232.h,
              width: 180.w,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 232.h,
            width: 180.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColors.pink500,
                width: 5.sp,
              ),
            ),
          ),

          // ! distance from you
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.h,
            child: Column(
              children: [
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
                    "1.3km away",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11.spMin,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ! username and age
                    SizedBox(
                      width: 87.w,
                      child: Text(
                        '${user.username}, ${user.age}',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18.spMin,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    // ! verification tag
                    Icon(
                      Icons.circle,
                      size: 6.spMin,
                      color: AppColors.green300,
                    )
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  user.location!,
                  style: TextStyle(
                    fontSize: 11.spMin,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 103.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: AppColors.pink500,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
            ),
            child: Text(
              '${user.noOfApples} ${user.noOfApples == 1 ? 'apple' : 'apples'}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.spMin,
                color: Colors.white,
              ),
            ),
          ).top(),
        ],
      ),
    );
  }
}
