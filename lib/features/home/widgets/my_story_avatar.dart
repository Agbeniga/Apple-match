import 'dart:ui';
import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyStoryAvatar extends StatelessWidget {
  final VoidCallback onTap;

  const MyStoryAvatar({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // get the user's avatar from shared preference
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(99.9.r),
                child: Stack(
                  children: [
                    Stack(
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
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(2.spMin),
                  height: 16.h,
                  width: 16.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFFFDF7FD),
                    ),
                    color: AppColors.pink500,
                  ),
                  child: Image.asset(AppIcons.add),
                ),
              )
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "My Story",
            style: TextStyle(
              fontSize: 14.spMin,
            ),
          )
        ],
      ),
    );
  }
}
