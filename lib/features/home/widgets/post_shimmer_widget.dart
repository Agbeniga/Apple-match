import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostShimmerWidget extends StatelessWidget {
  const PostShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return shimmerContainer();
      },
    );
  }

  shimmerContainer() {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 16.h),
      height: 343.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Colors.grey.shade300,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 72.h,
            left: 17.73.w,
            child: SizedBox(
              width: 273.64.w,
              child: Container(
                height: 20.h,
                width: 120.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            left: 17.73.w,
            child: SizedBox(
              width: 273.64.w,
              child: Container(
                height: 45.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.milliseconds);
  }
}
