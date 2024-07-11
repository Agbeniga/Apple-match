import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Options extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  const Options({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  // TODO: CREATE AN ANIMATION FOR THE BORDER TO APPEAR WHEN IT IS SELECTED

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(99.9),
        onTap: onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: EdgeInsets.only(left: 25.w, right: 16.w),
          width: double.maxFinite,
          height: 54.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFFFF5069) : Colors.white,
              width: isSelected ? 2 : 0,
            ),
            borderRadius: BorderRadius.circular(99.9),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 16.spMin,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              !isSelected
                  ? Icon(
                      Icons.circle_outlined,
                      size: 24.spMin,
                      weight: 1.5,
                      color: const Color(0xFF999999),
                    )
                  : SvgPicture.asset('assets/icons/circle_bold.svg')
            ],
          ),
        ),
      ),
    );
  }
}
