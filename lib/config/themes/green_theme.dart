import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData greenTheme = ThemeData(
  primaryColor: AppColors.activeGreen, // 主题色
  scaffoldBackgroundColor: AppColors.page, // 脚手架下的页面背景色
  indicatorColor: AppColors.activeGreen, // 选项卡栏中所选选项卡指示器的颜色。
  // ElevatedButton 主题
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // 文字颜色
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        } else {
          return null;
        }
      }),
      // 背景色
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.activeGreen.withOpacity(0.5);
        } else {
          return AppColors.activeGreen;
        }
      }),
    ),
  ),
  splashColor: Colors.transparent, // 取消水波纹效果
  highlightColor: Colors.transparent, // 取消水波纹效果
  hoverColor: Colors.white.withOpacity(0.5),
  textTheme: TextTheme(
      bodyText2: const TextStyle(
        color: AppColors.unactive, // 文字颜色
      ),
      //要支持下面这个需要使用第一种初始化方式 --- 字体适配
      button: TextStyle(fontSize: 30.sp)),
  // tabbar的样式
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: AppColors.unactive,
    labelColor: Colors.black,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 30.sp,
    ),
    labelPadding: EdgeInsets.symmetric(vertical: 10.h),
  ),
  appBarTheme: AppBarTheme(
      backgroundColor: AppColors.activeGreen,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 40.sp),
      iconTheme: const IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.page,
    selectedItemColor: AppColors.activeGreen,
    unselectedItemColor: AppColors.unactive,
    selectedLabelStyle: TextStyle(
      fontSize: 28.sp,
    ),
  ),
);
