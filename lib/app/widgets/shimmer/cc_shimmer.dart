import "package:flutter/material.dart";
import "package:page_penner/core/values/colors.dart";
import "package:shimmer/shimmer.dart";

class CCShimmer extends StatelessWidget {
  final double width;
  final double height;

  const CCShimmer({
    Key? key,
    this.width = 150,
    this.height = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: surfaceVariant,
      highlightColor: neutral,
      period: const Duration(seconds: 2),
      child: Container(
        width: width,
        height: height,
        decoration: const ShapeDecoration(
          color: outline,
          shape: RoundedRectangleBorder(),
        ),
      ),
    );
  }
}
