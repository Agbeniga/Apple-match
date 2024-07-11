import 'package:applematch/models/payment_tier.dart';

List<PaymentTier> paymentTierConstants = const [
  PaymentTier(
    name: "Basic Apple Pack",
    price: 9.99,
    description:
        "100 Apples, basic profile customization, see who accepted apples",
  ),
  PaymentTier(
    name: "Premium Apple Pack",
    price: 19.99,
    description:
        "200 Apples, Priority visibility, advanced filters, access to “Golden Apples”",
  ),
  PaymentTier(
    name: "Premium Apple Pack",
    price: 29.99,
    description: "No limit to Apples access to “Golden Apples”",
  ),
];
