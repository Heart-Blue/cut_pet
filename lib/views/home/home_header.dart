import 'package:cute_pet/components/animated_widget.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class HomeHeader extends StatelessWidget {
  HomeHeader({Key? key}) : super(key: key);
  final _appThemeController = Get.find<AppThemeController>();
  final _profileController = Get.find<ProfileController>();
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: 430.h,
      title: EmptyAnimatedSwitcher(
        child: _appBarImg(),
        display: _homeController.isShowAppImg,
      ),
      centerTitle: false,
      actions: [
        EmptyAnimatedSwitcher(
          child: _selectPetBtn(),
          display: _homeController.isShowAppImg,
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _nav(),
      ),
    );
  }

  Widget _appBarImg() {
    return Container(
      width: 75.w,
      height: 75.w,
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Colors.white),
        borderRadius: BorderRadius.circular(75.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75.w),
        child: GetBuilder(
          init: _profileController,
          builder: (_) {
            return NetLoadImage(imageUrl: _profileController.petInfo.petImg);
          },
        ),
      ),
    );
  }

  // 选择宠物
  Widget _selectPetBtn() {
    return InkWell(
      onTap: () {
        Get.toNamed('/petList');
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.page,
          borderRadius: BorderRadius.circular(30.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.only(right: 20.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'choose_a_pet'.tr,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Transform.rotate(
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h, right: 10.w),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 24.w,
                  color: Colors.black,
                ),
              ),
              angle: math.pi,
            )
          ],
        ),
      ),
    );
  }

  Widget _nav() {
    return SafeArea(
      child: Container(
        color: AppColors.page,
        child: Stack(
          children: [
            _navHeadImg(),
            Positioned(top: 200.h, child: _navCard()),
            Positioned(right: 0, top: 20.h, child: _selectPetBtn())
          ],
        ),
      ),
    );
  }

  Widget _navHeadImg() {
    return GetBuilder(
        init: _appThemeController,
        builder: (_) {
          return Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 80.h, left: 30.w),
                color: AppColors.appthemeColor(_appThemeController.themeMark),
                height: 330.h,
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/editPet');
                      },
                      child: Container(
                        width: 120.w,
                        height: 120.w,
                        margin: EdgeInsets.only(right: 20.w),
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(150.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150.w),
                          child: GetBuilder(
                            init: _profileController,
                            builder: (_) {
                              return NetLoadImage(
                                  imageUrl: _profileController.petInfo.petImg);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 500.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetBuilder(
                            init: _profileController,
                            builder: (_) {
                              return Text(
                                _profileController.petInfo.petName.isNotEmpty
                                    ? _profileController.petInfo.petName
                                    : 'not_logged'.tr,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 30.sp, color: Colors.white),
                              );
                            },
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          GetBuilder(
                            init: _profileController,
                            builder: (_) {
                              return Text(
                                _profileController.petInfo.day,
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    fontSize: 24.sp, color: Colors.white),
                              );
                            },
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          GetBuilder(
                            init: _profileController,
                            builder: (_) {
                              return Text(
                                _profileController.petInfo.age.isNotEmpty
                                    ? '${_profileController.petInfo.age}|${_profileController.petInfo.petBreed}|${_profileController.petInfo.petKg}KG'
                                    : '',
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    fontSize: 24.sp, color: Colors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _navCardItem({required String url, required String name}) {
    return InkWell(
      onTap: () {
        if (_profileController.hasToken) {
          EasyLoading.showSuccess(name);
        } else {
          Get.toNamed('/login');
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            GetBuilder<AppThemeController>(
                init: AppThemeController(),
                builder: (_) {
                  return Image.asset(
                    url,
                    color: AppColors.appthemeColor(_.themeMark),
                  );
                }),
            SizedBox(height: 10.h),
            Text(name)
          ],
        ),
      ),
    );
  }

  Widget _navCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 35.h),
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 35.h),
      width: Get.width - 60.w,
      decoration: BoxDecoration(
        color: AppColors.page,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.w)],
        borderRadius: BorderRadius.circular((20.w)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _navCardItem(url: 'assets/images/home_record.png', name: 'daily_clock'.tr),
            _navCardItem(url: 'assets/images/home_fit.png', name: 'health_manage'.tr),
            _navCardItem(url: 'assets/images/home_weight.png', name: 'weight_record'.tr),
            _navCardItem(url: 'assets/images/home_album.png', name: 'rookie_help'.tr),
            _navCardItem(url: 'assets/images/home_warn.png', name: 'feeding_guide'.tr),
          ],
        ),
      ),
    );
  }
}
