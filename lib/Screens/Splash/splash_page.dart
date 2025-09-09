// views/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../CSS/color.dart';
import '../../CSS/image_page.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      body: Center(
        child: ScaleTransition(
          scale: controller.animation,
          alignment: Alignment.center,
          child: Image.asset(AppImages.imageLogo, height: 150.h),
        ),
      ),
    );
  }
}
