import 'package:applematch/config/constants/payment_tier_constants.dart';
import 'package:applematch/models/payment_tier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentTierProvider = StateProvider<PaymentTier>(
  (ref) => paymentTierConstants[0],
);
