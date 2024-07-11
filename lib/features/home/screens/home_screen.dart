import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/providers/get_all_post_provider.dart';
import 'package:applematch/config/providers/story_provider.dart';
import 'package:applematch/features/home/widgets/my_story_avatar.dart';
import 'package:applematch/features/home/widgets/post_shimmer_widget.dart';
import 'package:applematch/features/messages/widgets/message_match_shimmer.dart';
import 'package:applematch/features/notification/screens/notification_screen.dart';
import 'package:applematch/mock/mock_posts.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/post_container.dart';
import 'package:applematch/shared/widgets/draggable_button.dart';
import 'package:applematch/shared/widgets/user_story_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final posts = ref.watch(getAllPostProvider);
    final stories = ref.watch(storyProvider);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
           Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            return Future.delayed(
              1.2.seconds,
              () => ref.refresh(getAllPostProvider),
            );
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                titleSpacing: 24.w,
                centerTitle: false,
                floating: true,
                snap: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Text(
                  "Apple Match",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32.spMin,
                    color: AppColors.black100,
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(99.9.r),
                      onTap: () => Navigator.pushNamed(
                        context,
                        NotificationScreen.route,
                      ),
                      child: Ink(
                        padding: EdgeInsets.all(10.spMin),
                        height: 48.h,
                        width: 48.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.purple500.withOpacity(0.2),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(99.9.r),
                        ),

                        // ! check if any notification is available
                        child: SvgPicture.asset(
                          AppIcons.notificationBadge,
                        ),
                      ),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size(double.maxFinite, 22.h),
                  child: Container(),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // ! stories
                    SizedBox(
                      height: 91.h,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        scrollDirection: Axis.horizontal,
                        children: [
                          MyStoryAvatar(onTap: () {}),
                          SizedBox(width: 20.w),
                          stories.when(
                            data: (allStories) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allStories.length,
                                itemBuilder: (context, index) {
                                  return UserStoryAvatar(
                                    index: index,
                                    storyList: allStories,
                                  );
                                },
                              );
                            },
                            error: (error, stk) => const Icon(Icons.error),
                            loading: () => SizedBox(
                              height: 91.h,
                              child: const UserAvatarShimmer(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // ! tab button
                    const DraggableButton(),

                    SizedBox(height: 24.h),

                    posts.when(
                        data: (allPosts) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: mockPosts.length,
                            itemBuilder: (context, index) {
                              final post = allPosts[index];
                              return PostContainer(
                                isUserProfile: false,
                                post: post,
                              ).center();
                            },
                          );
                        },
                        error: (error, stk) => const Icon(Icons.error),
                        loading: () => const PostShimmerWidget())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
