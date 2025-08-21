import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:public_ip_address/public_ip_address.dart';
import '../../CSS/color.dart';
import '../../CSS/image_page.dart';
import '../../util/base_services.dart';
import '../../util/local_store_data.dart';
import '../../util/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var animation;
  late AnimationController animatedContainer;
  bool isActive = false;
  LocalStorage localStorage = LocalStorage();
  var isUser;

  @override
  void initState() {
    super.initState();
    animatedContainer = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animatedContainer.forward();
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animatedContainer,
        curve: Interval(0.10, 0.50, curve: Curves.fastOutSlowIn),
      ),
    );
    setState(() {
      isActive = true;
    });

    _getIp();
    getUser();
  }

  bool isLoadings = false;

  Future<void> getUser() async {
    isLoadings = true;
    setState(() {});
    try {
      isUser = await localStorage.getUId();
      var response = await hitUserAPI();
      Get.log("Coming Response :${response['success']}");
      if (response['success'] == true) {
        print(response['data'][0]['client_id']);
        localStorage.saveData(
          "client_id",
          response['data'][0]['client_id'].toString(),
        );
        String hex = response['data'][0]['themeColor'].toString().replaceAll(
          '#',
          '',
        );
        if (hex.length == 6) hex = 'FF$hex';
        Color dynamicColor = Color(int.parse(hex, radix: 16));
        AppColor.dynamicColor = dynamicColor;
        isLoadings = false;
        setState(() {});
        nextPage(context);
      } else {
        isLoadings = false;
        setState(() {});
        nextPage(context);
      }
    } on Exception catch (exception) {
      isLoadings = false;
      Get.log("Exception : ${exception.toString()}");
      setState(() {
        nextPage(context);
      });
    }
  }

  void _getIp() async {
    IpAddress _ipAddress = IpAddress();
    var ip = await _ipAddress.getIp();
    setState(() {});
    print("IP Address: ${ip}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ScaleTransition(
                scale: animation,
                alignment: Alignment.center,
                child: Image.asset(AppImages.imageLogo, height: 150.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  nextPage(BuildContext context) {
    print("is users : $isUser");
    Future.delayed(const Duration(seconds: 3), () async {
      isUser == null || isUser == "null"
          ? Get.offNamed(RouteManager.loginPage)
          : Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
    });
  }
}
