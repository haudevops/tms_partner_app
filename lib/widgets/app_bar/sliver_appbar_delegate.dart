import 'package:flutter/material.dart';
import 'dart:math' as math;

class DynamicHeader extends SliverPersistentHeaderDelegate {
  DynamicHeader({
    required this.minHeight,
    required this.maxHeight,
    required this.child
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
