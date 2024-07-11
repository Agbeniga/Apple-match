import 'package:flutter_riverpod/flutter_riverpod.dart';

final ageRangeStartProvider = StateProvider<double>((ref) => 0.18);
final ageRangeEndProvider = StateProvider<double>((ref) => 0.18);

final appleRangeStartProvider = StateProvider<double>((ref) => 0.0);
final appleRangeEndProvider = StateProvider<double>((ref) => 0.0);

final spaceRangeStartProvider = StateProvider<double>((ref) => 0.0);
final spaceRangeEndProvider = StateProvider<double>((ref) => 0.0);

final setUpProvider = StateProvider<bool>((ref) => true);
