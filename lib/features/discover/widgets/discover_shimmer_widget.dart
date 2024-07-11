import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverShimmerWidget extends StatelessWidget {
  const DiscoverShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return shimmerContainer();
      },
    );
  }

  shimmerContainer() {
    return Container(
      margin: EdgeInsets.only(right: 20.w),
      height: 160.h,
      width: 105.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade300,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 12.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 14.h,
                  width: 81.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: Colors.grey.shade400.withOpacity(0.3),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 15.h,
                  width: 81.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: Colors.grey.shade400.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.milliseconds);
  }
}
