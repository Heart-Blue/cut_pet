import 'dart:async';

import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  int currentTime = 6;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        currentTime--;
      });
      if (currentTime <= 0) {
        _jumpRootPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  // 跳转到首页
  void _jumpRootPage() {
    // 取消定时器
    _timer.cancel();
    Get.offNamed('/root');
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/launch_image.png',
            fit: BoxFit.cover,
            width: appSize.width,
            height: appSize.height,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20.h,
            right: MediaQuery.of(context).padding.right + 20.w,
            child: _clipButton(),
          )
        ],
      ),
    );
  }

  // 跳过按钮
  Widget _clipButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.w),
      child: Material(
        child: InkWell(
          onTap: _jumpRootPage,
          child: Container(
            width: 100.w,
            height: 100.w,
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'skip'.tr,
                  style: TextStyle(color: AppColors.page, fontSize: 24.sp),
                ),
                Text(
                  '${currentTime}s',
                  style: TextStyle(color: AppColors.page, fontSize: 24.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
