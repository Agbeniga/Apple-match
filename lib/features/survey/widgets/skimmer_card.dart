import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class SkimmerCard extends StatelessWidget {
  const SkimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16),),
        ),
        child: const FadeShimmer(
          height: 152,
          width: double.infinity,
          radius: 16,
          fadeTheme: FadeTheme.light,
          highlightColor: Color(0xffF9F9FB),
          baseColor: Color(0xffE6E8EB),
        ),
      ),
    );
  }
}
