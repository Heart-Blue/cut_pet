import 'package:cute_pet/caches/app_config.dart';
import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/internationalization/message.dart';
import 'package:cute_pet/config/themes/default.dart';
import 'package:cute_pet/controllers/all_controller_binding.dart';
import 'package:cute_pet/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

void main() {
  //WidgetsFlutterBinding是框架和flutter引擎之间的胶水
  WidgetsFlutterBinding.ensureInitialized();

  // EasyLoading初始化
  AppConfig.initEasyLoading();

  SharedStorage.getWelcome().then((value) {
    runApp( MyApp(isWelcome: value));
  });
}

class MyApp extends StatelessWidget {
  final bool isWelcome;
  const MyApp({Key? key, required this.isWelcome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (ctx,child) => GetMaterialApp(
        title: 'appTitle'.tr,
        debugShowCheckedModeBanner: false,
        initialRoute: isWelcome ? Routes.initialWelcome : Routes.initialLauch, //初始化路由
        defaultTransition: Transition.fadeIn, //默认路由跳转过渡动画
        //路由列表
        getPages: Routes.routePages,
        theme: defaultTheme,
        builder: EasyLoading.init(),
        initialBinding: AllControllerBinding(), //初始化getController
        translations: Messages(), // 你的翻译
        locale: const Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
        fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不
      ),
    );
  }
}
