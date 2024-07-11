import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/survey/providers/gender_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GenderButton extends StatelessWidget {
  final VoidCallback onTap;
  final Genders selectedGender;
  final Genders gender;

  const GenderButton({
    super.key,
    required this.onTap,
    required this.selectedGender,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      onTap: onTap,
      borderRadius: BorderRadius.circular(200.r),
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: 300.ms,
        alignment: Alignment.center,
        height: 200.h,
        width: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.r),
          color:
              selectedGender == gender ? AppColors.pink500 : AppColors.pink50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              gender == Genders.male
                  ? FontAwesomeIcons.mars
                  : FontAwesomeIcons.venus,
              size: 31.spMin,
              color: selectedGender == gender ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 14.04),
            Text(
              gender == Genders.male ? "Male" : "Female",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 18.spMin,
                  fontWeight: FontWeight.w500,
                  color: selectedGender == gender ? Colors.white : Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
