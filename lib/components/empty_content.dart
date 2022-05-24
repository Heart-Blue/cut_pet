import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmptyContent extends StatelessWidget {
  final double size;
  final String data;
  final bool isLoading;
  final Function()? onTap;
  const EmptyContent(
      {Key? key,
      this.size = 0,
      this.data = 'temporarily_no_data',
      this.onTap,
      this.isLoading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appThemeController = Get.find<AppThemeController>();
    return !isLoading
        ? InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder(
                  init: _appThemeController,
                  initState: (_) {},
                  builder: (_) {
                    return Image.asset(
                      'assets/images/nodata.png',
                      color: AppColors.appthemeColor(
                          _appThemeController.themeMark),
                      width: size == 0 ? 100.w : size,
                      height: size == 0 ? 100.w : size,
                    );
                  },
                ),
                Text(data.isNotEmpty ? data : 'temporarily_no_data'.tr)
              ],
            ),
          )
        : GetBuilder<AppThemeController>(init: AppThemeController(),builder: (_) {
          return CircularProgressIndicator(
            color: AppColors.appthemeColor(_.themeMark),
          );
        });
  }
}
