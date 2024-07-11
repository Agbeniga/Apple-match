import 'package:applematch/shared/widgets/avatar_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatarShimmer extends StatelessWidget {
  final double? height;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const UserAvatarShimmer({super.key, this.height, this.physics, this.padding});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      shrinkWrap: true,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w),
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AvatarShimmer(height: 60.h),
              SizedBox(height: 4.h),
              Container(
                height: 12.h,
                width: 60,
                color: Colors.grey.shade300,
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1.2.seconds)
            ],
          ),
        );
      },
    );
  }
}
