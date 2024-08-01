import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerWidget extends StatelessWidget {
  const AppShimmerWidget({
    super.key,
    this.isCircle = false,
    this.borderRadius,
  });

  final bool isCircle;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).hoverColor,
      highlightColor: Theme.of(context).highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: borderRadius,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
