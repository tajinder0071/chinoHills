import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../controller/package_cotroller.dart';
import 'detai_body.dart';

class PackageDetailPage extends GetView<PackageController> {
  final String? sectionName;

  var controller = Get.put(PackageController());

  PackageDetailPage({super.key, this.sectionName});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      body: DetailBody(),
    );
  }
}
