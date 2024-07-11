import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/providers/get_match_provider.dart';
import 'package:applematch/features/messages/widgets/chat_room_tile.dart';
import 'package:applematch/features/messages/widgets/message_match_container.dart';
import 'package:applematch/features/messages/widgets/message_match_shimmer.dart';
import 'package:applematch/mock/mock_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends ConsumerWidget {
  static const String route = '/message';

  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref.watch(getMatchProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          'New Matches',
          style: TextStyle(
            fontSize: 20.spMin,
            color: AppColors.pink500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 88.h,
              child: matches.when(
                data: (newMatches) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    scrollDirection: Axis.horizontal,
                    itemCount:0,
                    //  newMatches.length,
                    itemBuilder: (context, index) {
                      final user = newMatches[index];
                      return MessageMatchContainer(
                        user: user,
                        isActive: user.isOnline!,
                      );
                    },
                  );
                },
                error: (error, stk) => const Icon(Icons.error),
                loading: () => const UserAvatarShimmer(),
              ),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                'Messages',
                style: TextStyle(
                  fontSize: 20.spMin,
                  color: AppColors.pink500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16.spMin),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemCount: 0,
              // 9,
              itemBuilder: (context, index) {
                return ChatRoomTile(
                  user: mockUsers[2],
                  lastMessage: "Oh i don't like Eba 🙈",
                  messageOwner: mockUsers[4],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
