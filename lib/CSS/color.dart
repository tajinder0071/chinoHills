import 'package:flutter/material.dart';


//TODO >> Declare color in this page to access full app

class AppColor {
  Color background = Color(0xFFFFFFFF);
  Color lightBlackColor = Colors.black.withOpacity(0.65);
  Color blackColor = Colors.black;
  Color redColor = Colors.red;
  Color black80 = Colors.black54;
  Color whiteColor = Colors.white;
  Color light = Color(0xffE6E9F2);
  Color greyColor = Colors.grey;
  Color mediumGreyColor = Colors.grey.shade600;
  Color lightBlue = Color(0xfff56B9F4);
  Color blueColor = Colors.blue;
  Color transparent = Colors.transparent;
  Color? lightGrey = Color(0XFFEEEEEE); //Color(0XFFEEEEEE)
  Color gradiant1 = Color(0Xff0096F4);
  Color gradiant2 = Color(0Xff00CDF7);
  Color discoverBg = Color(0X00fefefe);
  Color greenColor = Colors.green;

  //TODO ?? dynamic color...

  // static Color dynamicColor = Color(0xFF441752);
  static Color dynamicColor = Color(0xFF0773D8);
  static Color disableButtonColor = dynamicColor.withAlpha(330);
  static Color dynamicShadow = dynamicColor.withAlpha(180);
  static Color dynamicColorWithOpacity = dynamicColor.withAlpha(25);
  static LinearGradient dynamicButtonColor = LinearGradient(
    colors: [AppColor.dynamicColor, AppColor.dynamicShadow],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Todo: >> Static Color
  static Color? geryBackGroundColor = Color(0XFFf5f5f5);
}
