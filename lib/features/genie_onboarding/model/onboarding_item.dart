import 'package:flutter/material.dart';

class OnboardingItem {
  final String image;
  final String topic;
  final String? category;
  final int? categoryIndex;
  final Widget subtopic;

  OnboardingItem({
    required this.image,
    required this.topic,
    this.category,
    this.categoryIndex,
    required this.subtopic,
  });
}
