import 'package:applematch/config/constants/constants.dart';

extension InterestExtension on String {
  String get fullInterest {
    return interestMap[this] ?? this;
  }
}
