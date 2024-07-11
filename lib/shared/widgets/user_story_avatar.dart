import 'package:animations/animations.dart';
import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/models/story.dart';
import 'package:applematch/shared/widgets/avatar_shimmer.dart';
import 'package:applematch/shared/widgets/story_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class UserStoryAvatar extends StatelessWidget {
  final int index;
  final List<Story> storyList;

  const UserStoryAvatar({
    super.key,
    required this.index,
    required this.storyList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: CupertinoButton(
        onPressed: () => pushWithoutNavBar(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                StoryScreen(stories: storyList, index: index),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.vertical,
                child: child,
              );
            },
          ),
        ),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 64.h,
                  width: 64.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99.r),
                    border: Border.all(width: 2, color: AppColors.pink500),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99.r),
                  child: CachedNetworkImage(
                    imageUrl: storyList[index].user!.imageUrl!,
                    placeholder: (context, url) => AvatarShimmer(height: 64.h),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 56.h,
                    width: 56.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            SizedBox(
              width: 64.w,
              child: Text(
                storyList[index].user!.username!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14.spMin,
                  color: AppColors.black200,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
