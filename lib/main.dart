import 'package:chino_hills/util/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chino_hills/Screens/Splash/splash_page.dart';
import 'package:chino_hills/util/route_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Stripe.publishableKey = CommonPage().stripePublishKey;
  await Stripe.instance.applySettings();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          behavior: HitTestBehavior.translucent,
          child: GetMaterialApp(
            title: 'Nima',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            themeMode: ThemeMode.light,
            home: SplashScreen(),
            getPages: RouteManager.routes,
          ),
        );
      },
    );
  }
}
