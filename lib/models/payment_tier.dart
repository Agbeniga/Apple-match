import 'package:flutter/material.dart';

@immutable
class PaymentTier {
  final String name;
  final double price;
  final String description;

  const PaymentTier({
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  String toString() =>
      'PaymentTier(description: $description, price: $price, name: $name)';
}
