import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final bool isLast;
  final String description;

  StepWidget({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99.9.r),
                color: color,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    color: color.withOpacity(0.2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24.spMin,
              ),
            ),
            Opacity(
              opacity: isLast ? 0 : 1,
              child: Stack(
                children: [
                  Container(
                    width: 6.w,
                    height: 40.h,
                    color: const Color(0xFF2C2C2E),
                  ),
                  Container(
                    width: 6.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(99.9.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 17.spMin,
                  fontWeight: FontWeight.w700,
                  color: color == Colors.pink ? Colors.pink : Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.spMin,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
