import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DescriptionWidget extends StatelessWidget {
  final String description;

  DescriptionWidget({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text.rich(
        TextSpan(
          children: _buildTextSpans(description),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.spMin, color: AppColors.grey700),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String text) {
    List<TextSpan> spans = [];
    List<String> parts = text.split("*");
    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        spans.add(TextSpan(text: parts[i]));
      } else {
        spans.add(TextSpan(text: parts[i], style: TextStyle(color: AppColors.pink500, fontSize: 14.spMin,),),);
      }
    }
    return spans;
  }
}