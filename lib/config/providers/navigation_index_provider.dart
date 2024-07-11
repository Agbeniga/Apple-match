import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

final persistentTabControllerProvider =
    Provider.autoDispose<PersistentTabController>((ref) {
  final controller = PersistentTabController();
  return controller;
});
