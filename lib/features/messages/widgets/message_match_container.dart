import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/widgets/avatar_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageMatchContainer extends StatelessWidget {
  final User user;
  final bool isActive;

  const MessageMatchContainer({
    super.key,
    required this.user,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60.r),
                child: CachedNetworkImage(
                  imageUrl: user.imageUrl!,
                  placeholder: (context, url) => AvatarShimmer(height: 60.h),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 60.h,
                  width: 60.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: 60.w,
                child: Text(
                  user.username!,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14.spMin,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black100,
                  ),
                ),
              )
            ],
          ),
          isActive
              ? Positioned(
                  top: 10.49.h,
                  right: -2.w,
                  child: Container(
                    height: 12.h,
                    width: 12.h,
                    decoration: BoxDecoration(
                      color: AppColors.green200,
                      borderRadius: BorderRadius.circular(99.r),
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
