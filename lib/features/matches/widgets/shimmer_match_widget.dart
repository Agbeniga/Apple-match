import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShimmerMatchWidget extends StatelessWidget {
  const ShimmerMatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      crossAxisSpacing: 20.w,
      mainAxisSpacing: 20.w,
      itemCount: 10,
      itemBuilder: (context, index) {
        return shimmerContainer();
      },
    );
  }

  shimmerContainer() {
    return Container(
      height: 232.h,
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        color: Colors.grey.shade300,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 14.h,
                  width: 83.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: Colors.grey.shade400.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 14.h,
                  width: 94.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: Colors.grey.shade400.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 14.h,
                  width: 83.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: Colors.grey.shade400.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(duration: 1.2.seconds);
  }
}
