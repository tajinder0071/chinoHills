import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonHorizontalList<T> extends StatelessWidget {
  final List<T> items;
  final double? itemWidth;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final EdgeInsetsGeometry itemMargin;
  final ScrollPhysics? physics;
  final double? height;

  const CommonHorizontalList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.itemWidth,
    this.itemMargin = const EdgeInsets.symmetric(horizontal: 5),
    this.physics,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        physics: physics,
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            margin: itemMargin,
            child: itemBuilder(context, items[index], index),
          );
        },
      ),
    );
  }
}
