import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Genders { male, female }

final genderProvider = StateProvider<Genders>((ref) => Genders.male);
