import 'dart:ui';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/providers/navigation_index_provider.dart';
import 'package:applematch/features/discover/screens/discover_screen.dart';
import 'package:applematch/features/home/screens/home_screen.dart';
import 'package:applematch/features/matches/screens/matches_screen.dart';
import 'package:applematch/features/messages/screens/message_screen.dart';
import 'package:applematch/features/profile/screens/account_screen.dart';
import 'package:applematch/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavigationScreen extends ConsumerWidget {
  static const String route = '/bottom-navigation';
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = ref.watch(persistentTabControllerProvider);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: PersistentTabView(
        controller: tabController,
        navBarHeight: 70.h,
        screenTransitionAnimation: const ScreenTransitionAnimation.none(),
        tabs: [
          PersistentTabConfig(
            screen: const HomeScreen(),
            item: ItemConfig(
              icon: SvgPicture.asset(AppIcons.homeActive),
              inactiveIcon: SvgPicture.asset(AppIcons.home),
            ),
          ),
          PersistentTabConfig(
            screen: const DiscoverScreen(),
            item: ItemConfig(
              icon: SvgPicture.asset(AppIcons.compassActive),
              inactiveIcon: SvgPicture.asset(AppIcons.compass),
            ),
          ),
          PersistentTabConfig(
            screen: const MatchesScreen(),
            item: ItemConfig(
              icon: SvgPicture.asset(AppIcons.flameActive),
              inactiveIcon: SvgPicture.asset(AppIcons.flame),
            ),
          ),
          PersistentTabConfig(
            screen: const MessageScreen(),
            item: ItemConfig(
              icon: SvgPicture.asset(AppIcons.messageActive),
              inactiveIcon: SvgPicture.asset(AppIcons.message),
            ),
          ),
          PersistentTabConfig(
            screen: const AccountScreen(),
            item: ItemConfig(
              icon: SvgPicture.asset(AppIcons.userActive),
              inactiveIcon: SvgPicture.asset(AppIcons.user),
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.r),
            ),
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 70,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

  const CustomNavBar({
    super.key,
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
  });

  Widget _buildItem(ItemConfig item, bool isSelected) {
    return Expanded(
      child: !isSelected ? item.icon : item.icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedNavBar(
      decoration: navBarDecoration,
      filter: navBarConfig.selectedItem.filter,
      opacity: navBarConfig.selectedItem.opacity,
      height: navBarConfig.navBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navBarConfig.items.map(
          (item) {
            int index = navBarConfig.items.indexOf(item);
            return Expanded(
              child: InkWell(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  navBarConfig.onItemSelected(
                    index,
                  ); // This is the most important part. Without this, nothing would happen if you tap on an item.
                },
                child: _buildItem(
                  item,
                  navBarConfig.selectedIndex == index,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
