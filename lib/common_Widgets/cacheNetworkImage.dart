import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../CSS/color.dart';
import '../CSS/image_page.dart';
import '../util/common_page.dart';

class ConstantNetworkImage extends StatelessWidget {
  ConstantNetworkImage(
      {super.key,
        this.imageUrl,
        this.height,
        this.width,
        this.errorWidget,
        this.boxFit = BoxFit.fill,
        required this.isLoad});

  final Widget? errorWidget;
  var imageUrl;
  var height, width;
  BoxFit boxFit;
  bool isLoad;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      filterQuality: FilterQuality.high,
      imageBuilder: (context, imageProvider) => InkWell(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                filterQuality: FilterQuality.high,
                fit: boxFit,
                image: imageProvider,
                onError: (exception, stackTrace) {
                  Icon(Icons.person);
                },
              ),
            ),
          ),
        ),
      ),
      errorListener: (value) => Icon(Icons.error),
      errorWidget: (context, url, error) {
        return Container(
          clipBehavior: Clip.antiAlias,
          height: height,
          width: width,
          decoration: BoxDecoration(color: AppColor.geryBackGroundColor),
          child: errorWidget ??
              Center(
                  child: Image.asset(
                    AppImages.noAvailableImage,
                    color: AppColor().blackColor,
                    // width: 150.w,
                    // height: 150.h,
                    fit: BoxFit.cover,
                  )),
        );
      },
    );
  }
}
