

import 'package:applematch/features/survey/widgets/interests_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalListWithTwoColumns extends StatelessWidget {
  final List children;
  final double height;

  const HorizontalListWithTwoColumns({
    super.key,
    required this.children,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Adjust height as needed
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        scrollDirection: Axis.horizontal,
        itemCount: (children.length / 2).ceil(),
        itemBuilder: (context, index) {
          final int firstIndex = index * 2;
          final int secondIndex = firstIndex + 1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InterestsContainer(
                text: children[firstIndex],
                bottomPadding: 12.h,
              ),
              if (secondIndex < children.length)
                InterestsContainer(
                  text: children[secondIndex],
                  bottomPadding: 12.h,
                ),
            ],
          );
        },
      ),
    );
  }
}