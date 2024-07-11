import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/features/notification/widgets/matched_notification_tile.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/apple_notification_tile.dart';
import 'package:applematch/shared/widgets/filter_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  static const String route = '/notification';
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleSpacing: 24.w,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBackButton(isCircular: true),
            Text(
              "NOTIFICATIONS",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 32.spMin,
                color: AppColors.pink500,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(99.9.r),
              onTap: () {
                 showSettingsMenu(context);
              },
              child: Ink(
                height: 48.h,
                width: 48.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.purple500.withOpacity(0.2),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(99.9.r),
                ),
                child: SvgPicture.asset(AppIcons.menu).center(),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              // ! apples received
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Apples Received",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.spMin,
                      color: AppColors.black100,
                    ),
                  ),
                  SizedBox(height: 23.h),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 0,
                    itemBuilder: (context, index) {
                      return AppleNotificationTile(
                        user: User(
                          username: "username",
                          age: 23,
                          noOfApples: 30,
                          location: 'location',
                          imageUrl:
                              'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-olly-3763188.jpg&fm=jpg',
                        ),
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 48.h),

              // ! matched
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Matched",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.spMin,
                      color: AppColors.black100,
                    ),
                  ),
                  SizedBox(height: 23.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 0,
                    itemBuilder: (context, index) {
                      return MatchedNotificationTile(
                        user: User(
                          username: "Hansen",
                          age: 23,
                          noOfApples: 30,
                          location: 'location',
                          imageUrl:
                              'https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-olly-3763188.jpg&fm=jpg',
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
