import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/features/messages/widgets/chat_room_screen.dart';
import 'package:applematch/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ChatRoomTile extends StatelessWidget {
  final User user;
  final User messageOwner;
  final String lastMessage;

  const ChatRoomTile({
    super.key,
    required this.user,
    required this.messageOwner,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.spMin),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomScreen(user: user),
          ),
        ),
        child: Ink(
          width: double.maxFinite,
          child: Row(
            children: [
              SizedBox(
                width: 73.w,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99.9.r),
                      child: CachedNetworkImage(
                        imageUrl: user.imageUrl!,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator.adaptive(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 60.h,
                        width: 60.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 2.h,
                      right: 0.w,
                      child: appleNumber(user.noOfApples!),
                    )
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.username!,
                        style: TextStyle(
                          fontSize: 16.spMin,
                          color: AppColors.black100,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5.8.w),
                      user.isVerified! || false
                          ? Container()
                          : SvgPicture.asset(
                              AppIcons.verified,
                              height: 16.25.spMin,
                            )
                    ],
                  ),
                  Text(
                    messageOwner != user
                        ? 'You: $lastMessage'
                        : "Oh i don't like Eba 🙈",
                    style: TextStyle(
                      fontSize: 15.spMin,
                      color: AppColors.grey700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // TODO: LAST MESSAGE LENGTH
              Container(
                alignment: Alignment.center,
                height: 24.h,
                width: 24.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99.r),
                  color: AppColors.pink500,
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 12.spMin,
                    color: const Color(0xFFFEFFFF),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  appleNumber(int noOfApples) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppImages.appleNumber,
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 9.h),
          child: Text(
            '$noOfApples',
            style: TextStyle(
              fontSize: 16.spMin,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
