import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color active = Color(0xfff4c92b);
  static const Color activeBlue = Color(0xff2195f2);
  static const Color activeOrange = Color(0xffff5722);
  static const Color activeGreen = Color(0xff009688);
  static const Color activeBrown = Color(0xff795548);

  static const Color unactive = Color(0xff7b7b7b);

  static const Color page = Color(0xfff1f1f1);

  // 颜色值转换
  static Color string2Color(String colorString) {
    int value = 0x00000000;
    if (colorString.isNotEmpty) {
      if (colorString[0] == '#') {
        colorString = colorString.substring(1);
      }
      value = int.tryParse(colorString, radix: 16)!;
      if (value < 0xFF000000) {
        value += 0xFF000000;
      }
    }
    return Color(value);
  }

  // 根据themeMark的值返回相应的颜色
  static Color appthemeColor(int mark) {
    if (mark == 1) {
      return active;
    } else if (mark == 2) {
      return activeBlue;
    } else if (mark == 3) {
      return activeOrange;
    } else if (mark == 4) {
      return activeGreen;
    } else if (mark == 5) {
      return activeBrown;
    }
    return active;
  }
}
