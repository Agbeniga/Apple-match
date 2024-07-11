import 'package:applematch/models/payment_tier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentTierContainer extends StatelessWidget {
  final PaymentTier tier;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentTierContainer({
    super.key,
    required this.tier,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 22.w),
        padding: EdgeInsets.fromLTRB(14.w, 20.h, 14.w, 0.h),
        width: 195.w,
        height: 250.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? Border.all(
                  width: 2,
                  color: const Color(0xFFDF3170),
                )
              : null,
          color: Colors.black.withOpacity(0.4),
        ),
        child: Column(
          children: [
            Text(
              tier.name,
              style: GoogleFonts.nunito(
                fontSize: 14.spMin,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6.h),
            Divider(
              color: Colors.white.withOpacity(0.2),
              height: 0.5,
            ),
            SizedBox(height: 6.h),
            SizedBox(
              width: 152.w,
              child: Text(
                "${tier.price.toStringAsFixed(2)} per month",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Divider(
              color: Colors.white.withOpacity(0.2),
              height: 0.5,
            ),
            SizedBox(height: 6.h),
            Text(
              tier.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.spMin,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
