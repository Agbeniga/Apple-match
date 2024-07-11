import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchedNotificationTile extends StatelessWidget {
  final User user;
  final int noOfExchangedApples;

  const MatchedNotificationTile({
    super.key,
    required this.user,
    this.noOfExchangedApples = 20,
  });

  @override
  Widget build(BuildContext context) {
    String formatDateTime(DateTime dateTime) {
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inSeconds < 60) {
        return 'now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.spMin),
      width: double.maxFinite,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(99.9.r),
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 60.h,
              width: 60.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: user.username,
                  style: GoogleFonts.poppins(
                    fontSize: 16.spMin,
                    color: AppColors.black100,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: ' exchanged apples ',
                      style: GoogleFonts.nunito(
                        fontSize: 14.spMin,
                        color: AppColors.grey700,
                      ),
                    ),
                    TextSpan(
                      text: '($noOfExchangedApples)',
                      style: GoogleFonts.nunito(
                        fontSize: 14.spMin,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pink500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formatDateTime(DateTime.now()),
                style: GoogleFonts.nunito(
                  fontSize: 14.spMin,
                  color: AppColors.grey700,
                ),
              ),
            ],
          ),
          const Spacer(),
          PrimaryButton(
            text: "Message",
            width: 89.w,
            height: 34.h,
          )
        ],
      ),
    );
  }
}
