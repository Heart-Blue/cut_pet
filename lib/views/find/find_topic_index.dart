import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/find_topic_index_controller.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:cute_pet/views/find/find_topic_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:math' as math;

class FindTopicIndex extends StatelessWidget {
  FindTopicIndex({Key? key}) : super(key: key);
  final _findTopicIndexController = Get.find<FindTopicIndexController>();
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _findTopicIndexController,
        builder: (_) {
          return _findTopicIndexController.contentList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: PullRefresher.customHeader,
                  footer: PullRefresher.customFooter,
                  controller: _findTopicIndexController.refreshController,
                  onRefresh: _findTopicIndexController.onRefresh,
                  onLoading: _findTopicIndexController.onLoading,
                  child: CustomScrollView(
                    slivers: [
                      renderNav(),
                      renderContentTitle(),
                      renderContentList()
                    ],
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _findTopicIndexController.isLoading,
                    data: _findTopicIndexController.prompt,
                    onTap: () {
                      _findTopicIndexController.isLoading = true;
                      _findTopicIndexController.update();
                      _findTopicIndexController.onRefresh();
                    },
                  ),
                );
        });
  }

  Widget renderNav() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [renderNavTitle(), renderNavContent()],
        ),
      ),
    );
  }

  Widget renderNavTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'hot_topic'.tr,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
              color: Colors.black),
        ),
        InkWell(
          onTap: () {
            Get.toNamed('/topicPetMore');
          },
          child: Row(
            children: [
               Text('more'.tr),
              SizedBox(
                width: 10.w,
              ),
              Transform.rotate(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 22.w,
                  color: AppColors.unactive,
                ),
                angle: math.pi,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget renderNavContent() {
    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _findTopicIndexController.findTopImgList.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20.w,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return renderNavContentCard(index);
        },
      ),
    );
  }

  Widget renderNavContentCard(int index) {
    return GetBuilder(
        init: _findTopicIndexController,
        builder: (_) {
          return Container(
            height: 300.h,
            width: 200.w,
            margin: EdgeInsets.only(top: 20.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                border: Border.all(
                    width: 1.0, color: AppColors.unactive.withOpacity(0.2))),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
                      child: NetLoadImage(
                        imageUrl: _findTopicIndexController
                            .findTopImgList[index].headImg,
                        width: 200.w,
                        height: 170.h,
                      ),
                    ),
                    Positioned(
                        bottom: 0.h,
                        child: Container(
                          color: AppColors.unactive.withOpacity(0.3),
                          width: 200.w,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30.w,
                              ),
                              Text(
                                "${_findTopicIndexController.findTopImgList[index].tribeUserCount}人",
                                style: TextStyle(
                                    fontSize: 26.sp, color: Colors.white),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(
                    _findTopicIndexController.findTopImgList[index].tribeName,
                    style: TextStyle(color: Colors.black, fontSize: 30.sp),
                  ),
                ),
                renderFocusBtn(isFocus: false, callBack: () {})
              ],
            ),
          );
        });
  }

  Widget renderFocusBtn({required bool isFocus, required Function() callBack}) {
    return InkWell(
      onTap: callBack,
      child: GetBuilder(
        init: _appThemeController,
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                border: Border.all(
                    width: 1.0,
                    color:
                        AppColors.appthemeColor(_appThemeController.themeMark)),
                color: !isFocus
                    ? AppColors.appthemeColor(_appThemeController.themeMark)
                    : Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                    child: Icon(
                  Icons.add,
                  size: 20.w,
                  color: isFocus
                      ? AppColors.appthemeColor(_appThemeController.themeMark)
                      : Colors.white,
                )),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  isFocus ? '已关注' : '关注',
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: isFocus
                          ? AppColors.appthemeColor(
                              _appThemeController.themeMark)
                          : Colors.white),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget renderContentTitle() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Text(
                'hot_discussion'.tr,
                style: TextStyle(
                    fontSize: 32.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 1.h,
              color: AppColors.unactive.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderContentList() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: ListView.separated(
          shrinkWrap: true, //范围内进行包裹（内容多高ListView就多高
          physics: const NeverScrollableScrollPhysics(), //禁止滚动）
          itemCount: _findTopicIndexController.contentList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1.h,
              color: AppColors.unactive.withOpacity(0.3),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return FindTopicItem(
                findTopicContentItemModel:
                    _findTopicIndexController.contentList[index]);
          },
        ),
      ),
    );
  }
}
