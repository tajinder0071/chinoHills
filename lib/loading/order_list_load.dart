import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import '../CSS/color.dart';

class OrderListLoad extends StatelessWidget {
  const OrderListLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, index) {
          return Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor().whiteColor,
            ),
          );
        },
      ),
    );
  }
}
