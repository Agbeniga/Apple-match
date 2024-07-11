import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftSliderContainer extends ConsumerStatefulWidget {
  final int appBalance;

  const GiftSliderContainer({super.key, required this.appBalance});

  @override
  ConsumerState<GiftSliderContainer> createState() =>
      _GiftSliderContainerState();
}

class _GiftSliderContainerState extends ConsumerState<GiftSliderContainer> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final appleGiftValue = ref.watch(appleGiftProvider);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 14.w),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
        side: const BorderSide(
          width: 2,
          color: AppColors.purple100,
        ),
      ),
      child: Ink(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 15.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Select Amount Of Apples To Gift",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.spMin,
                        color: const Color(0xFF30242A),
                      ),
                    ),
                    SizedBox(height: 34.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        giftButton(
                            index == 0, widget.appBalance, 'Apple balance',
                            onTap: () {
                          setState(() {
                            index = 0;
                          });
                        }),
                        SizedBox(width: 8.w),
                        giftButton(index == 1, (appleGiftValue * 100),
                            'Amount Selected', onTap: () {
                          setState(() {
                            index = 1;
                          });
                        }),
                      ],
                    ),
                    SizedBox(height: 53.h),
                    RangeSlider(
                      values: RangeValues(0, appleGiftValue),
                      onChanged: (value) => ref
                          .read(appleGiftProvider.notifier)
                          .state = value.end,
                      activeColor: AppColors.purple500,
                      inactiveColor: AppColors.pink100,
                    ),
                    SizedBox(height: 10.h),
                    PrimaryButton(
                      text: "Confirm",
                      width: 199.w,
                      height: 48.h,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // selection buttons

  giftButton(bool isSelected, num value, String text,
      {required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.only(left: 22.w, top: 8.h),
        width: 160.w,
        height: 90.h,
        decoration: BoxDecoration(
          border: !isSelected ? Border.all(color: AppColors.purple500) : null,
          borderRadius: BorderRadius.circular(12.r),
          color: !isSelected ? Colors.white : AppColors.purple500,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 12.spMin,
                fontWeight: FontWeight.w500,
                color: !isSelected ? AppColors.purple500 : Colors.white,
              ),
            ),
            SizedBox(height: 7.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: 'gift basket',
                  child: Image.asset(
                    AppImages.appleBasket,
                    width: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  value.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 30.spMin,
                    fontWeight: FontWeight.w700,
                    color: !isSelected ? AppColors.purple500 : Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final appleGiftProvider = StateProvider<double>((_) => 0.0);
