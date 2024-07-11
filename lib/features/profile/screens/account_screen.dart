import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/constants/profile_constants.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/providers/notification_providers.dart';
import 'package:applematch/features/bot/screens/apple_genie_screen.dart';
import 'package:applematch/features/profile/screens/edit_profile_screen.dart';
import 'package:applematch/features/profile/widget/profile_list_tile.dart';
import 'package:applematch/features/profile/widget/profile_section.dart';
import 'package:applematch/mock/mock_users.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/app_rounded_info_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AccountScreen extends ConsumerWidget {
  static const String route = "/account";
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ! get use detials
    final user = mockUsers[1];
    final pushNotificationState = ref.watch(pushNotificationProvider);
    final promotionalNotificationState = ref.watch(
      promotionalNotificationProvider,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 32.spMin,
                  fontWeight: FontWeight.w500,
                  color: AppColors.pink500,
                ),
              ).left(),
              SizedBox(height: 24.h),

              // ! profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(99.9.r),
                child: CachedNetworkImage(
                  imageUrl:  user.imageUrl!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator.adaptive(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 88.h,
                  width: 88.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h),
              // ! username
              Text(
               user.username!,
                style: TextStyle(
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black100,
                ),
              ),

              // ! user email
              Text(
                 user.email!,
                style: TextStyle(
                  fontSize: 14.spMin,
                  color: AppColors.grey700,
                ),
              ),
              SizedBox(height: 24.h),
              ProfileSection(
                title: "My Account",
                child: Column(
                  children: List.generate(
                    myAccountConstants.length,
                    (index) => ProfileListTile(
                      leading: SvgPicture.asset(
                        myAccountConstants[index]["leading"]!,
                      ),
                      title: myAccountConstants[index]["title"]!,
                      trailing: myAccountConstants[index]["trailing"] == null
                          ? null
                          : Text(
                              myAccountConstants[index]["trailing"]!,
                              style: TextStyle(fontSize: 14.spMin),
                            ),
                      onTap: () {
                        switch (myAccountConstants[index]["title"]) {
                          case "Personal information":
                            pushWithoutNavBar(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfileSCreen(),
                              ),
                            );
                            break;
                          case "Apple Genie":
                           pushWithoutNavBar(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppleGenieScreen(),
                              ),
                            );
                            break;
                        }
                      },
                    ),
                  ).toList(),
                ),
              ),
              SizedBox(height: 4.h),
              ProfileSection(
                title: "Notifications",
                child: Column(
                  children: [
                    ProfileListTile(
                      leading: SvgPicture.asset(AppIcons.bell),
                      title: "Push Notifications",
                      trailing: FlutterSwitch(
                        value: pushNotificationState,
                        onToggle: (value) => ref
                            .read(pushNotificationProvider.notifier)
                            .state = value,
                        width: 30.w,
                        height: 18.h,
                        activeColor: AppColors.green100,
                        toggleSize: 10.sp,
                      ),
                    ),
                    ProfileListTile(
                      leading: SvgPicture.asset(AppIcons.bell),
                      title: "Promotional Notifications",
                      trailing: FlutterSwitch(
                        value: promotionalNotificationState,
                        onToggle: (value) => ref
                            .read(promotionalNotificationProvider.notifier)
                            .state = value,
                        width: 30.w,
                        height: 18.h,
                        activeColor: AppColors.green100,
                        toggleSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              ProfileSection(
                title: "More",
                child: Column(
                  children: [
                    ProfileListTile(
                      onTap: () {},
                      leading: SvgPicture.asset(AppIcons.notification),
                      title: "Help Center",
                    ),
                    ProfileListTile(
                      onTap: () {},
                      leading: SvgPicture.asset(AppIcons.logout),
                      title: "Log Out",
                      color: AppColors.red100,
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 9.h),
                child: AppRoundedInfoContainer(
                  leading: Container(
                    color: Colors.transparent,
                    child: CircularPercentIndicator(
                      radius: 20.0,
                      lineWidth: 4.0,
                      percent: 0.9,
                      center: Text(
                        "90%",
                        style: TextStyle(
                          fontSize: 12.spMin,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: AppColors.purple100.withOpacity(0.3),
                      progressColor: AppColors.purple100,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  text: "Complete",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
