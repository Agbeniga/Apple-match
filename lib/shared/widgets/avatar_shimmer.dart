import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarShimmer extends StatelessWidget {
  final double height;
  const AvatarShimmer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: Colors.grey.shade200,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1.2.seconds);
  }
}
