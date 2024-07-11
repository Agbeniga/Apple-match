import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/models/post.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/extensions/interests_extension.dart';
import 'package:applematch/shared/widgets/avatar_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  final bool isProfile;
  final bool isUserProfile;

  const PostContainer({
    super.key,
    required this.post,
    this.isProfile = false,
    this.isUserProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isProfile && !isUserProfile) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Stack(
          children: [
            // ! background image
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: CachedNetworkImage(
                imageUrl: post.imageUrl!,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 343.h,
                width: 380.w,
                fit: BoxFit.cover,
              ),
            ),

            // ! section
            Positioned(
              top: 16.h,
              left: 14.4.w,
              child: Container(
                alignment: Alignment.center,
                width: 106.w,
                height: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Text(
                  post.interest!.fullInterest,
                  style: TextStyle(
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ).animate().shakeY(),
            ),

            // ! title
            Positioned(
              bottom: 72.h,
              left: 17.73.w,
              child: SizedBox(
                width: 273.64.w,
                child: Text(
                  post.description!,
                  style: TextStyle(
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 12.h,
              left: 17.73.w,
              child: SizedBox(
                width: 273.64.w,
                child: Row(
                  children: [
                    // ! user profile image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99.r),
                      child: CachedNetworkImage(
                        imageUrl: post.owner!.imageUrl!,
                        placeholder: (context, url) =>
                            AvatarShimmer(height: 44.h),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 44.h,
                        width: 44.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 13.61.w),

                    // ! user details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.owner!.username!,
                          style: TextStyle(
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          post.owner!.location!,
                          style: TextStyle(
                            fontSize: 11.spMin,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // !action buttons
            // Positioned(
            //   top: 0,
            //   right: 0,
            //   bottom: 0,
            //   child: Stack(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.only(
            //           left: 17.73.w,
            //           right: 8.86.w,
            //           top: 10.h,
            //           bottom: 10.h,
            //         ),
            //         height: 184.h,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.horizontal(
            //             left: Radius.circular(24.r),
            //           ),
            //           color: Colors.white.withOpacity(0.4),
            //         ),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             // ! apples
            //             InkWell(
            //               onTap: () {},
            //               child: Container(
            //                 padding: EdgeInsets.fromLTRB(
            //                   8.18.w,
            //                   5.h,
            //                   9.14.w,
            //                   7.13.h,
            //                 ),
            //                 height: 40.h,
            //                 width: 40.h,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(99.r),
            //                   color: Colors.white.withOpacity(0.4),
            //                 ),
            //                 child: Image.asset(
            //                   AppIcons.apple,
            //                 ),
            //               ),
            //             ),

            //             // ! comments
            //             InkWell(
            //               onTap: () {},
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(
            //                   vertical: 8.h,
            //                   horizontal: 10.08,
            //                 ),
            //                 height: 40.h,
            //                 width: 40.h,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(99.r),
            //                   color: Colors.white.withOpacity(0.4),
            //                 ),
            //                 child: SvgPicture.asset(
            //                   AppIcons.comment,
            //                 ),
            //               ),
            //             ),

            //             // ! more
            //             InkWell(
            //               onTap: () {},
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(
            //                   vertical: 10.h,
            //                   horizontal: 11.08,
            //                 ),
            //                 height: 40.h,
            //                 width: 40.h,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(99.r),
            //                   color: Colors.white.withOpacity(0.4),
            //                 ),
            //                 child: SvgPicture.asset(
            //                   AppIcons.moreHoriz,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ).center(),
            //     ],
            //   ),
            // )
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Stack(
          children: [
            // ! background image
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: CachedNetworkImage(
                imageUrl: post.imageUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 343.h,
                width: 380.w,
                fit: BoxFit.cover,
              ),
            ),

            // ! section
            Positioned(
              top: 16.h,
              left: 14.4.w,
              child: Container(
                alignment: Alignment.center,
                width: 106.w,
                height: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Text(
                  post.interest!.fullInterest,
                  style: TextStyle(
                    fontSize: 16.spMin,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // ! title
            Positioned(
              bottom: 18.h,
              left: 17.73.w,
              child: SizedBox(
                width: 273.64.w,
                child: Text(
                  post.description!,
                  style: TextStyle(
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
