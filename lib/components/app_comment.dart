import 'package:cute_pet/components/focus_button.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppComment {
  // 文章详情头部
  static Widget header(
      {required String headImg,
      required String nickname,
      required String createTime,
      required String followStatus,
      required Function() callBack}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(75.w),
                child: NetLoadImage(
                  imageUrl: headImg,
                  width: 75.w,
                  height: 75.w,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nickname,
                    style: TextStyle(fontSize: 26.sp, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    createTime,
                    style: TextStyle(fontSize: 24.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          FocusButton(
            name: followStatus,
            onPressed: callBack,
          ),
        ],
      ),
    );
  }

  // 文章的labelName
  static Widget themeTitle(
      {required String labelName,
      required AppThemeController appThemeController}) {
    return labelName.isNotEmpty
        ? GetBuilder(
            init: appThemeController,
            builder: (_) {
              return Text(
                '#' + labelName,
                style: TextStyle(
                    fontSize: 24.sp,
                    color:
                        AppColors.appthemeColor(appThemeController.themeMark)),
              );
            })
        : const SizedBox.shrink();
  }
}
