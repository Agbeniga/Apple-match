import 'dart:ui';
import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/mock/mock_users.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PhoneCallScreen extends StatelessWidget {
  final User user;
  static const String route = '/phone-call';

  const PhoneCallScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // get user details
    final currentUser = mockUsers[0];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 36.h),
                // ! Other user
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: user.imageUrl!,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade300,
                            child: Icon(
                              IconsaxPlusBold.user,
                              size: 50.sp,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 8.0,
                              sigmaY: 8.0,
                            ),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99.r),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 4),
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 4,
                                    )
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(99.r),
                                child: CachedNetworkImage(
                                  imageUrl: user.imageUrl!,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey.shade300,
                                    child: Icon(
                                      IconsaxPlusBold.user,
                                      size: 50.sp,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  width: 70.h,
                                  height: 70.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              "${user.username}'s camera is off".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.spMin,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // ! Currently logged in user
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: currentUser.imageUrl!,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade300,
                            child: Icon(
                              IconsaxPlusBold.user,
                              size: 50.sp,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 8.0,
                              sigmaY: 8.0,
                            ),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99.r),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 4),
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 4,
                                    )
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(99.r),
                                child: CachedNetworkImage(
                                  imageUrl: currentUser.imageUrl!,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey.shade300,
                                    child: Icon(
                                      IconsaxPlusBold.user,
                                      size: 50.sp,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  width: 70.h,
                                  height: 70.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              "Your camera is off".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.spMin,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ! back button
          Padding(
            padding: EdgeInsets.only(left: 17.w),
            child: const SafeArea(
              child: AppBackButton(
                isCircular: true,
                color: AppColors.pink500,
              ),
            ),
          ),

          // ! video call action buttons
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 32.w),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.purple500,
                border: Border.all(
                  color: const Color(0xFFDD88CF),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 70,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  speaker
                  Image.asset(
                    AppIcons.speaker,
                    height: 32.h,
                    width: 32.h,
                  ),

                  // unmute/mute
                  Image.asset(
                    AppIcons.muteUnmute,
                    height: 32.h,
                    width: 32.h,
                  ),

                  // turn on/off video
                  Image.asset(
                    AppIcons.videoCall,
                    height: 32.h,
                    width: 32.h,
                  ),

                  // message
                  SvgPicture.asset(
                    AppIcons.message,
                    height: 32.h,
                    width: 32.h,
                    color: Colors.white,
                  ),

                  // !terminate call button
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    child: Container(
                      height: 32.h,
                      width: 32.h,
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99.r),
                        color: AppColors.red50,
                      ),
                      child: Image.asset(
                        AppIcons.callFilled,
                        height: 32.h,
                        width: 32.h,
                      ),
                    ),
                  )
                ],
              ),
            ).bottom(),
          ),
        ],
      ),
    );
  }
}
