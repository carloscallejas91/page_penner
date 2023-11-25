import "package:flutter/material.dart";
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
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(seconds: 2),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.outline,
          shape: const RoundedRectangleBorder(),
        ),
      ),
    );
  }
}