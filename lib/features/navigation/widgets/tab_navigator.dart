import 'package:applematch/config/constants/tab_item.dart';
import 'package:applematch/router.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key,
      required this.navigatorKey,
      required this.tabItem,
      required this.initialRoute});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
