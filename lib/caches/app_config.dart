import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppConfig {
  // EasyLoading初始化
  static void initEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = true;
  }
}
