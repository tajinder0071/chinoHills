import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../CSS/color.dart';
import '../util/common_page.dart';

class CommonNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final dynamic height;
  final dynamic width;
  final dynamic fit;
  final BorderRadiusGeometry borderRadius;

  const CommonNetworkImageWidget(
      {super.key,
      required this.imageUrl,
      required this.fit,
      required this.height,
      required this.width,
      required this.borderRadius});

  // 5625462361

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(imageUrl.toString(),
          filterQuality: FilterQuality.high,
          fit: fit, errorBuilder: (context, url, error) {
        return Container(
          clipBehavior: Clip.antiAlias,
          height: height,
          width: width,
          decoration:
              BoxDecoration(color: Colors.black12, borderRadius: borderRadius),
          child: Center(
              child: Image.asset(
            "assets/images/Image_not_available.png",
            color: AppColor().blackColor,
            fit: BoxFit.cover,
          )),
        );
      }, loadingBuilder: (BuildContext ctx, Widget child,
              ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child; //  Return fully loaded image
        }
        return SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Platform.isAndroid
                ? commonLoader(color: AppColor.dynamicColor)
                : CupertinoActivityIndicator(color: AppColor.dynamicColor),
          ),
        );
      }, height: height, width: width),
    );
  }
}
