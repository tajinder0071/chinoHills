import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CircularNetworkImage extends StatelessWidget {
  const CircularNetworkImage(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.shimmerHeight,
      this.shimmerWidth,
      this.errorIconSize = 50,
      this.fit = BoxFit.cover,
      this.iconsErrorColor,
      this.errorWidget,
      this.errorIcon});

  final String imageUrl;
  final double? height;
  final Color? iconsErrorColor;
  final double? width;
  final double? shimmerHeight;
  final double? shimmerWidth;
  final BoxFit fit;
  final double errorIconSize;
  final Widget? errorWidget;
  final IconData? errorIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        filterQuality: FilterQuality.high,
        imageBuilder: (context, imageProvider) => InkWell(
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    fit: fit,
                    image: imageProvider,
                    onError: (exception, stackTrace) {
                      const Icon(Iconsax.user);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        errorListener: (value) => const Icon(Iconsax.user),
        errorWidget: (context, url, error) {
          return errorWidget ??
              const Center(
                child: Icon(Icons.error),
              );
        },
      ),
    );
  }
}

class CommonNetworkImageError extends StatelessWidget {
  const CommonNetworkImageError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.error,
      size: 45,
      color: Colors.white70,
    );
  }
}
