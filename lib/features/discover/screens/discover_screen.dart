import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/constants/constants.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/providers/discover_people_provider.dart';
import 'package:applematch/features/discover/providers/map_provider.dart';
import 'package:applematch/features/discover/widgets/discover_card.dart';
import 'package:applematch/features/discover/widgets/discover_shimmer_widget.dart';
import 'package:applematch/features/survey/widgets/interests_container.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/filter_bottomsheet.dart';
import 'package:applematch/shared/widgets/horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  static const String route = '/discover';
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  bool viewAllInterests = false;
  int? selectedIndex;

  // @override
  // void initState() {
  //    WidgetsBinding.instance.addPostFrameCallback((_) {
  //     //TODO: Generate dummy chats, remove this line when chats are being fetched from the server
  //     ref.read(chatController.notifier).generateChats();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final discoverNewUsers = ref.watch(discoverPeopleProvider);
    final position = ref.watch(mapProvider);
    final mapController = ref.read(mapProvider.notifier).controller;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              titleSpacing: 24.w,
              centerTitle: false,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(
                "Discover",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32.spMin,
                  color: AppColors.pink500,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(99.9.r),
                    onTap: () {},
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
                      child: SvgPicture.asset(
                        AppIcons.search,
                        height: 24,
                      ).center(),
                    ),
                  ),
                ),
                // ! menu button
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: InkWell(
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
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size(double.maxFinite, 22.h),
                child: Container(),
              ),
            ),

            // ! discover new user's
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160.h,
                child: discoverNewUsers.when(
                  data: (users) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: 0,
                      // users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return DiscoverCard(user: user);
                      },
                    );
                  },
                  error: (error, stk) => const Icon(Icons.error),
                  loading: () => const DiscoverShimmerWidget(),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: 20.h,
                bottom: 24.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Interest",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.spMin,
                            color: AppColors.black100,
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(99.r),
                          onTap: () {
                            setState(() {
                              viewAllInterests = !viewAllInterests;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "View all",
                              style: TextStyle(
                                fontSize: 14.spMin,
                                color: AppColors.pink500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    HorizontalListWithTwoColumns(
                      height: 115.h,
                      children: viewAllInterests
                          ? interestsConstants
                          : interestsConstants.sublist(0, 8),
                    ),
                    Wrap(
                      children: List.generate(
                        viewAllInterests ? interestsConstants.length : 5,
                        (index) => InterestsContainer(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          text: interestsConstants[index],
                          isSelected: selectedIndex == index,
                          bottomPadding: 12.h,
                          isSingleSelect: true,
                        ),
                      ).animate(interval: 150.ms).fadeIn(duration: 50.ms),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Around me",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.spMin,
                        color: AppColors.black100,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    RichText(
                      text: TextSpan(
                        text: "People with ",
                        style: TextStyle(
                          fontSize: 14.spMin,
                          color: AppColors.grey700,
                        ),
                        children: [
                          TextSpan(
                            text: "“Music”",
                            style: TextStyle(
                              fontSize: 14.spMin,
                              color: AppColors.pink500,
                            ),
                          ),
                          TextSpan(
                            text: " interest around you",
                            style: TextStyle(
                              fontSize: 14.spMin,
                              color: AppColors.grey700,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // TODO: A MAP

                    SizedBox(
                      height: 374.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: position,
                                onMapCreated: (GoogleMapController controller) {
                                  mapController.complete(controller);
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final spaceProvider = StateProvider<double>((ref) => 0.0);
}
