import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/features/messages/widgets/chat_room_screen.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class ItsAMatchScreen extends ConsumerWidget {
  static const String route = '/its-a-match';

  final User matchedUser;

  const ItsAMatchScreen({
    super.key,
    required this.matchedUser,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.pink500,
                  Color(0xFFCB1F5D),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 76.63.w,
            top: 165.84.h,
            child: SvgPicture.asset(AppIcons.like),
          ),
          Positioned(
            left: 89.w,
            top: 187.h,
            child: Transform.rotate(
              angle: -math.pi / 7,
              child: SvgPicture.asset(AppIcons.like),
            ),
          ),
          Positioned(
            right: 134.2.w,
            top: 266.h,
            child: Transform.rotate(
              angle: -math.pi / -180,
              child: SvgPicture.asset(
                AppIcons.like,
                height: 37.h,
                width: 37.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 50.w,
            bottom: 274.77.h,
            child: Transform.rotate(
              angle: -math.pi / -180,
              child: SvgPicture.asset(AppIcons.like),
            ),
          ),
          Positioned(
            right: 49.69.w,
            bottom: 295.69.h,
            child: Transform.rotate(
              angle: -math.pi / 8,
              child: SvgPicture.asset(
                AppIcons.like,
                height: 37.h,
                width: 37.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 124.78.w,
            bottom: 210.78.h,
            child: Transform.rotate(
              angle: -math.pi / 6,
              child: SvgPicture.asset(AppIcons.like),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'It’s match🎉',
                style: TextStyle(
                  fontSize: 32.spMin,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'You and Justin have exchanged apples.',
                style: TextStyle(
                  fontSize: 16.spMin,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 26.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userAvatar(matchedUser.imageUrl!
                          // 'https://sb.kaleidousercontent.com/67418/1920x1281/0e9f02a048/christian-buehner-ditylc26zvi-unsplash.jpg',
                          ),
                      userAvatar(
                        'https://sb.kaleidousercontent.com/67418/1920x1281/0e9f02a048/christian-buehner-ditylc26zvi-unsplash.jpg',
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(16.h),
                    decoration: BoxDecoration(
                      color: AppColors.pink500,
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.white,
                      size: 32.sp,
                    ),
                  ),
                ],
              )
            ],
          ).center(),

          // TODO: based on the gender the him/her should be decided
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 110.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButton(
                    text: "Message Him",
                    color: Colors.white,
                    textColor: AppColors.pink500,
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ChatRoomScreen(
                          user: matchedUser,
                        );
                      }));
                    },
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Keep Swiping",
                      style: TextStyle(
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ).bottom(),
            ),
          )
        ],
      ),
    );
  }

  Widget userAvatar(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 6.75, color: Colors.white),
        borderRadius: BorderRadius.circular(99.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) =>
              const CircularProgressIndicator.adaptive(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 140.h,
          width: 140.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
