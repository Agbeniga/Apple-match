import 'package:applematch/config/constants/looking_for_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lookingForProvider =
    StateProvider<String>((ref) => lookingForConstants[0]);
