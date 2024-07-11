import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/config/providers/navigation_index_provider.dart';
import 'package:applematch/features/genie_onboarding/genie_onboarding_screen.dart';
import 'package:applematch/features/home/widgets/post_shimmer_widget.dart';
import 'package:applematch/features/profile/providers/user_post_provider.dart';
import 'package:applematch/features/profile/screens/account_screen.dart';
import 'package:applematch/features/survey/providers/interests_provider.dart';
import 'package:applematch/features/survey/widgets/interests_container.dart';
import 'package:applematch/mock/mock_users.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/extensions/interests_extension.dart';
import 'package:applematch/shared/widgets/app_rounded_info_container.dart';
import 'package:applematch/shared/widgets/gift_slider_container.dart';
import 'package:applematch/shared/widgets/post_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends ConsumerWidget {
  static const String route = '/profile';

  final User? userProfile;
  const ProfileScreen({super.key, this.userProfile});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationTabController = ref.watch(persistentTabControllerProvider);
    // ! get user id from shared preferences
    final user = mockUsers[1];

    final posts = ref.watch(
      userPostsProvider(
        userProfile != null ? userProfile!.userId! : user.userId!,
      ),
    );

  final interests = ref.watch(interestsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: InkWell(
        onTap: () {
        
        },
        child: InkWell(
          onTap: (){
            Navigator.of(context, rootNavigator: true).pushNamed(GenieOnboardingScreen.route);
          },
          child: AppRoundedInfoContainer(
            leading: Container(
              height: 40.h,
              width: 40.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.pink100.withOpacity(
                    0.3,
                  ),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(99.r),
              ),
              child: Image.asset(
                AppIcons.jasperAi2,
                height: 40.h,
                width: 40.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: 100.h,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(99.9),
                    onTap: () => userProfile != null
                        ? Navigator.pop(context)
                        : navigationTabController.jumpToTab(0),
                    child: Container(
                      width: 45.h,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(99.9.r),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 22.spMin,
                        weight: 2.37,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(99.9),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AccountScreen.route,
                    ),
                    child: Container(
                      width: 45.h,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(99.9.r),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 22.spMin,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(
                  top: 10.h,
                  bottom: 5.w,
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 8.h),
                    height: 5.h,
                    width: 134.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color(0xFFAFAFAF),
                    ),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.purple600,
            expandedHeight: 428.h,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                children: [
                  CachedNetworkImage(
                    // ! the user's profile image url
                    imageUrl: userProfile != null
                        ? userProfile!.imageUrl!
                        : user.imageUrl!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: double.maxFinite,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: null,
                    left: 0,
                    right: 0,
                    top: 290.h,
                    child: Column(
                      children: [
                        // ! username and age and location
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$usernameAndAge ",
                              style: TextStyle(
                                fontSize: 24.spMin,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                              ),
                            ),
                            // !location
                            Text(
                              location,
                              style: TextStyle(
                                fontSize: 14.spMin,
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // ! number of apples
                        Text(
                          "${user.noOfApples!} Apples",
                          style: TextStyle(
                            fontSize: 24.spMin,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.25),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 13.h),

                        // ! number of apples left OR gift apples
                        userProfile != null
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return GiftSliderContainer(
                                          appBalance: user.noOfApples!);
                                    },
                                  );
                                },
                                child: AppRoundedInfoContainer(
                                  leading: Container(
                                    height: 40.h,
                                    width: 40.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.pink100.withOpacity(
                                          0.3,
                                        ),
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(99.r),
                                    ),
                                    child: Hero(
                                      tag: 'gift basket',
                                      child: Image.asset(
                                        AppImages.appleBasket,
                                        height: 60.h,
                                        width: 60.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  text: 'Gift Apples',
                                ),
                              )
                            : AppRoundedInfoContainer(
                                leading: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  padding: EdgeInsets.all(4.sp),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.pink100.withOpacity(0.3),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(99.r),
                                  ),
                                  child: Image.asset(
                                    AppIcons.apple,
                                    height: 27.h,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                text: '${user.noOfApples} Apples Left',
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Container(
                margin: EdgeInsets.fromLTRB(24.w, 29.h, 24.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About ${userProfile != null ? 'You' : ''} ',
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: const Color(0xFF908B94),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // ! user's about or bio
                    Text(
                      user.bio!,
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: AppColors.purple700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Interest',
                          style: TextStyle(
                            fontSize: 16.spMin,
                            color: const Color(0xFF908B94),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // ! get's the info from the web i.e part of User details
                        Wrap(
                          children: List.generate(
                            interests!.length,
                            (index) => InterestsContainer(
                              text: interests![index].fullInterest,
                              bottomPadding: 12.h,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 14.h),
                    posts.when(
                      data: (userPosts) {
                        return ListView.builder(
                          padding: EdgeInsets.only(bottom: 20.h),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 0,
                          // userPosts.length,
                          itemBuilder: (context, index) {
                            return PostContainer(post: userPosts[index]);
                          },
                        );
                      },
                      error: (error, stk) => const Icon(Icons.error),
                      loading: () => const PostShimmerWidget(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String get usernameAndAge {
    final user = mockUsers[1];
    if (userProfile != null) {
      return "${userProfile!.username}, ${userProfile!.age}";
    } else {
      return "${user.username}, ${user.age}";
    }
  }

  get location {
    final user = mockUsers[1];
    if (userProfile != null) {
      return userProfile!.location!;
    } else {
      return user.location!;
    }
  }
}
