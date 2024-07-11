import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/providers/navigation_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DraggableButton extends ConsumerStatefulWidget {
  const DraggableButton({super.key});

  @override
  ConsumerState<DraggableButton> createState() => _DraggableButtonState();
}

class _DraggableButtonState extends ConsumerState<DraggableButton> {
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    final navigationTabController = ref.watch(persistentTabControllerProvider);

    navigationTabController.addListener(() {
      if (navigationTabController.index == 0) {
        setState(() {
          _alignment = Alignment.centerLeft;
        });
      }
    });

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Make Friends',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black100,
                        fontSize: 14.spMin,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Search Partners',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.black100,
                        fontSize: 14.spMin,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ! draggable container
          AnimatedAlign(
            curve: Curves.easeInOutExpo,
            duration: const Duration(milliseconds: 200),
            alignment: _alignment,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.4.w),
              width: 177.26.w,
              height: 36.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                _alignment == Alignment.centerLeft
                    ? 'Make Friends'
                    : 'Search Partners',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black100,
                  fontSize: 14.spMin,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: GestureDetector(onTap: () {
                setState(() {
                  _alignment = Alignment.centerLeft;
                });
              })),
              Expanded(child: GestureDetector(onTap: () {
                setState(() {
                  _alignment = Alignment.centerRight;
                });
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () => navigationTabController.jumpToTab(1),
                );
              })),
            ],
          )
        ],
      ),
    );
  }
}
