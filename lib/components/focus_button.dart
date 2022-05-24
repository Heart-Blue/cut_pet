import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FocusButton extends StatelessWidget {
  const FocusButton(
      {Key? key,
      required this.name,
      required this.onPressed,
      this.customColor = false})
      : super(key: key);
  final String name;
  final bool customColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final _appThemeController = Get.find<AppThemeController>();
    return InkWell(
      onTap: onPressed,
      child: GetBuilder(
        init: _appThemeController,
        initState: (_) {},
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
                color: customColor
                    ? Colors.white
                    : name == '未关注'
                        ? AppColors.appthemeColor(_appThemeController.themeMark)
                        : Colors.white,
                border: Border.all(
                    width: 1.0,
                    color: customColor
                        ? Colors.white
                        : AppColors.appthemeColor(
                            _appThemeController.themeMark)),
                borderRadius: BorderRadius.circular(5.w)),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              children: [
                Visibility(
                    visible: name == '未关注',
                    child: Icon(
                      Icons.add,
                      size: 30.w,
                      color: customColor ? Colors.black : Colors.white,
                    )),
                Text(
                  name == '未关注' ? '关注' : '已关注',
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: customColor
                          ? Colors.black
                          : name == '未关注'
                              ? Colors.white
                              : AppColors.appthemeColor(
                                  _appThemeController.themeMark)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
