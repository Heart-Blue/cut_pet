import 'package:cute_pet/config/themes/blue_theme.dart';
import 'package:cute_pet/config/themes/brown_theme.dart';
import 'package:cute_pet/config/themes/default.dart';
import 'package:cute_pet/config/themes/green_theme.dart';
import 'package:cute_pet/config/themes/orange_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppThemeController extends GetxController {
  // active  themeMark = 1
  // activeBlue  themeMark = 2
  // activeOrange  themeMark = 3
  // activeGreen themeMark = 4
  // activeBrown  themeMark = 5
  var themeMark = 1;

  // 改变自定义的主题
  void changeThemeMark(int mark) {
    themeMark = mark;
    update();
  }

  // 改变系统的主题
  ThemeData changeSystemTheme(int mark) {
    if (mark == 1) {
      return defaultTheme;
    } else if (mark == 2) {
      return blueTheme;
    } else if (mark == 3) {
      return orangeTheme;
    } else if (mark == 4) {
      return greenTheme;
    } else if (mark == 5) {
      return brownTheme;
    }
    return defaultTheme;
  }
}
