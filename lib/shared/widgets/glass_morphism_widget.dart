import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphismContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final Widget child;

  const GlassMorphismContainer({
    super.key,
    this.height,
    this.width,
    required this.child,
    required this.borderRadius,
  });

  @override
  State<GlassMorphismContainer> createState() => _GlassMorphismContainerState();
}

class _GlassMorphismContainerState extends State<GlassMorphismContainer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        height: widget.height,
        width: widget.width,
        color: Colors.transparent,
        child: Stack(
          children: [
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Container(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.grey.withOpacity(0.6),
                  ],
                ),
              ),
              child: widget.child,
            )
          ],
        ),
      ),
    );
  }
}
