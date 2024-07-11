import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/constants/constants.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/features/discover/providers/settings_providers.dart';
import 'package:applematch/features/profile/widget/profile_list_tile.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/horizontal_list.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

showSettingsMenu(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    elevation: 0,
    useRootNavigator: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.r),
        topRight: Radius.circular(40.r),
      ),
    ),
    builder: (context) {
      return Consumer(builder: (context, ref, child) {
        final ageRangeStart = ref.watch(ageRangeStartProvider);
        final ageRangeEnd = ref.watch(ageRangeEndProvider);

        final appleRangeStart = ref.watch(appleRangeStartProvider);
        final appleRangeEnd = ref.watch(appleRangeEndProvider);
        final spaceRangeStart = ref.watch(spaceRangeStartProvider);
        final spaceRangeEnd = ref.watch(spaceRangeEndProvider);
        final setUp = ref.watch(setUpProvider);

        return StatefulBuilder(builder: (context, setState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.75,
            maxChildSize: 0.9,
            builder: (context, controller) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        SizedBox(height: 24.h),
                        SizedBox(height: 21.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Set Up",
                                style: TextStyle(
                                  fontSize: 20.spMin,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.pink500,
                                ),
                              ),
                              FlutterSwitch(
                                value: setUp,
                                onToggle: (value) {
                                  ref.read(setUpProvider.notifier).state =
                                      value;
                                },
                                width: 37.5.w,
                                height: 22.5.h,
                                activeColor: AppColors.green100,
                                toggleSize: 10.sp,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              Text(
                                "Interested in",
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ).left(),
                              SizedBox(height: 16.h),
                              ProfileListTile(
                                leading: SvgPicture.asset(AppIcons.globe),
                                title: "Country",
                                trailing: Text(
                                  "All",
                                  style: TextStyle(
                                    fontSize: 16.spMin,
                                  ),
                                ),
                                itemSpacing: 8.w,
                                bottomPadding: 16.h,
                              ),
                              ProfileListTile(
                                leading: SvgPicture.asset(AppIcons.language),
                                title: "Language",
                                trailing: Text(
                                  "All",
                                  style: TextStyle(
                                    fontSize: 16.spMin,
                                  ),
                                ),
                                itemSpacing: 8.w,
                                bottomPadding: 16.h,
                              ),
                              ProfileListTile(
                                leading: SvgPicture.asset(AppIcons.cake),
                                title: "Age",
                                trailing: Text(
                                  "${(ageRangeStart * 100).toStringAsFixed(0)}-${(ageRangeEnd * 100).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 16.spMin,
                                  ),
                                ),
                                itemSpacing: 8.w,
                                bottomPadding: 4.h,
                              ),
                              RangeSlider(
                                min: 0.18,
                                max: 0.40,
                                values: RangeValues(ageRangeStart, ageRangeEnd),
                                activeColor: AppColors.pink500,
                                inactiveColor: const Color(0xFFE6E6E6),
                                onChanged: (values) {
                                  ref
                                      .read(ageRangeStartProvider.notifier)
                                      .state = values.start;
                                  ref.read(ageRangeEndProvider.notifier).state =
                                      values.end;
                                },
                              ),
                              ProfileListTile(
                                leading: SvgPicture.asset(
                                  AppIcons.apple2,
                                  height: 19.h,
                                ),
                                title: "Amount of Apples",
                                trailing: Text(
                                  "${(appleRangeStart * 100).toStringAsFixed(0)}-${(appleRangeEnd * 100).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 16.spMin,
                                  ),
                                ),
                                itemSpacing: 8.w,
                                bottomPadding: 4.h,
                              ),
                              RangeSlider(
                                values: RangeValues(
                                  appleRangeStart,
                                  appleRangeEnd,
                                ),
                                activeColor: AppColors.pink500,
                                inactiveColor: const Color(0xFFE6E6E6),
                                onChanged: (values) {
                                  ref
                                      .read(appleRangeStartProvider.notifier)
                                      .state = values.start;
                                  ref
                                      .read(appleRangeEndProvider.notifier)
                                      .state = values.end;
                                },
                              ),
                              ProfileListTile(
                                leading: SvgPicture.asset(AppIcons.signPost),
                                title: "Space",
                                trailing: Text(
                                  "${(spaceRangeStart * 100).toStringAsFixed(0)}-${(spaceRangeEnd * 100).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 16.spMin,
                                  ),
                                ),
                                itemSpacing: 8.w,
                                bottomPadding: 4.h,
                              ),
                              RangeSlider(
                                min: 0.0,
                                max: 0.4,
                                values:
                                    RangeValues(spaceRangeStart, spaceRangeEnd),
                                activeColor: AppColors.pink500,
                                inactiveColor: const Color(0xFFE6E6E6),
                                onChanged: (values) {
                                  ref
                                      .read(spaceRangeStartProvider.notifier)
                                      .state = values.start;
                                  ref
                                      .read(spaceRangeEndProvider.notifier)
                                      .state = values.end;
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Text(
                                "Interest",
                                style: TextStyle(
                                  fontSize: 16.spMin,
                                  color: AppColors.black200.withOpacity(0.5),
                                ),
                              ).left(),
                            ),
                            SizedBox(height: 12.h),
                            HorizontalListWithTwoColumns(
                              height: 115.h,
                              children: interestsConstants,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 40.h),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40.r),
                      ),
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 24.h),
                      height: 5.h,
                      width: 134.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99.r),
                        color: const Color(0xFFAFAFAF),
                      ),
                    ).top(),
                  ).top(),
                  SafeArea(
                    minimum:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                    child: PrimaryButton(
                      text: "Confirm",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ).bottom(),
                  ),
                ],
              );
            },
          );
        });
      });
    },
  );
}
