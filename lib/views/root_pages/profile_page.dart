import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final double spaceWidth = 40.w;
  final double spaceHeight = 30.h;
  final _profileController = Get.find<ProfileController>();
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
        actions: [
          IconButton(
              onPressed: () async {},
              icon: const Icon(Icons.notifications_active)),
          IconButton(
              onPressed: () async {
                String page =
                    _profileController.hasToken ? '/setting' : '/login';
                Get.toNamed(page);
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: spaceWidth, horizontal: spaceHeight),
              child: Column(
                children: [
                  nav(),
                  content(),
                  footer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 头部
  Widget header() {
    return GetBuilder(
        init: _profileController,
        builder: (_) {
          return GetBuilder(
              init: _appThemeController,
              builder: (_) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 35.h),
                  color: AppColors.appthemeColor(_appThemeController.themeMark),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150.w,
                            height: 150.w,
                            margin: EdgeInsets.only(right: 20.w),
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.white),
                              borderRadius: BorderRadius.circular(150.w),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150.w),
                              child: NetLoadImage(imageUrl: _profileController.profileInfo.userinfo.headImg),
                            ),
                          ),
                          SizedBox(
                            width: 200.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _profileController.profileInfo.userinfo
                                          .nickname.isNotEmpty
                                      ? _profileController
                                          .profileInfo.userinfo.nickname
                                      : 'not_logged'.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 34.sp, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  _profileController.profileInfo.user.userPhone,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      fontSize: 32.sp, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Transform.rotate(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 35.w,
                          color: Colors.white,
                        ),
                        angle: math.pi,
                      )
                    ],
                  ),
                );
              });
        });
  }

  Widget navItem(int count, String name) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: spaceHeight, horizontal: spaceWidth),
      child: Column(
        children: [
          Text(
            count.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 34.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: const TextStyle(color: AppColors.unactive),
          ),
        ],
      ),
    );
  }

  // nav导航栏
  Widget nav() {
    return GetBuilder(
      init: _profileController,
      builder: (_) {
        return Visibility(
          visible: _profileController.hasToken,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 4.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(-1.0, -1.0),
                      blurRadius: 4.0)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: navItem(
                      _profileController.profileInfo.agreeCount, 'praise'.tr),
                ),
                Expanded(
                    child: navItem(
                        _profileController.profileInfo.fansCount, 'fans'.tr)),
                Expanded(
                    child: navItem(_profileController.profileInfo.followCount,
                        'attention'.tr)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget contentTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spaceHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'my_pet'.tr,
            style: TextStyle(fontSize: 30.sp),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('all'.tr, style: TextStyle(fontSize: 30.sp)),
              Transform.rotate(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 2.h, right: 10.w),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 24.w,
                    color: AppColors.unactive,
                  ),
                ),
                angle: math.pi,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget contentCard(
      {required String headImg, required String name, required String age}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      margin: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w), color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.w),
            child: NetLoadImage(imageUrl: headImg,width: 100.w,height: 100.w,),
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                age,
                style: TextStyle(fontSize: 26.sp),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 我的动物内容
  Widget content() {
    return GetBuilder(
      init: _profileController,
      builder: (_) {
        return Visibility(
          visible: _profileController.hasToken,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contentTitle(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      _profileController.petList.length,
                      (index) => contentCard(
                          headImg: _profileController.petList[index].petImg,
                          name: _profileController.petList[index].petName,
                          age: _profileController.petList[index].age)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget footerItem({required String title, required Function() onTap}) {
    return ListTile(
      title: Text(title),
      trailing: Transform.rotate(
        child: Padding(
          padding: EdgeInsets.only(bottom: 2.h, right: 10.w),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 24.w,
            color: AppColors.unactive.withOpacity(0.5),
          ),
        ),
        angle: math.pi,
      ),
      onTap: onTap,
    );
  }

  Widget footer() {
    return Container(
      margin: EdgeInsets.only(top: spaceHeight),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.w)),
      child: Column(
        children: [
          footerItem(
              title: 'set_the_theme'.tr,
              onTap: () {
                Get.defaultDialog(
                    title: "select_theme".tr,
                    content: Column(
                      children: [
                        _selectThemeBtn('default'.tr, AppColors.active, 1),
                        _selectThemeBtn(
                            'theme'.tr + '1', AppColors.activeBlue, 2),
                        _selectThemeBtn(
                            'theme'.tr + '2', AppColors.activeOrange, 3),
                        _selectThemeBtn(
                            'theme'.tr + '3', AppColors.activeGreen, 4),
                        _selectThemeBtn(
                            'theme'.tr + '4', AppColors.activeBrown, 5),
                      ],
                    ),
                    backgroundColor: Colors.white,
                    barrierDismissible: true,
                    radius: 10);
              }),
          const Divider(),
          footerItem(
              title: 'set_the_language'.tr,
              onTap: () {
                Get.defaultDialog(
                    title: "",
                    titlePadding: const EdgeInsets.all(0),
                    content: _selectLanguageWidget(),
                    backgroundColor: Colors.white,
                    barrierDismissible: true,
                    radius: 10);
              }),
        ],
      ),
    );
  }

  // 切换主题
  Widget _selectThemeBtn(String text, Color background, int count) {
    return InkWell(
      onTap: () {
        // 切换自定义主题
        _appThemeController.changeThemeMark(count);
        // 切换app主题
        Get.changeTheme(_appThemeController.changeSystemTheme(count));
        EasyLoading.showSuccess(text);
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.back();
        });
      },
      child: Container(
        height: 50.h,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(color: background),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }

  // 切换语言
  Widget _selectLanguageWidget() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.updateLocale(const Locale('zh', 'CN'));
            EasyLoading.showSuccess('中文');
            Future.delayed(const Duration(milliseconds: 1000), () {
              Get.back();
            });
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: const Text('中文'),
          ),
        ),
        Divider(
          thickness: 1.5,
          color: Colors.black.withOpacity(0.2),
        ),
        InkWell(
          onTap: () {
            Get.updateLocale(const Locale('en', 'US'));
            EasyLoading.showSuccess('English');
            Future.delayed(const Duration(milliseconds: 1000), () {
              Get.back();
            });
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: const Text('English'),
          ),
        ),
      ],
    );
  }
}
