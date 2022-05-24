import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/find_focus_controller.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:cute_pet/views/find/find_foucs_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindFocusIndex extends StatelessWidget {
  FindFocusIndex({Key? key}) : super(key: key);
  final _findFocusController = Get.find<FindFocusController>();
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _findFocusController,
        builder: (_) {
          return _findFocusController.contentList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: PullRefresher.customHeader,
                  footer: PullRefresher.customFooter,
                  controller: _findFocusController.refreshController,
                  onRefresh: _findFocusController.onRefresh,
                  onLoading: _findFocusController.onLoading,
                  child: CustomScrollView(
                    slivers: [
                      renderFocusContent(),
                      renderPostList(),
                    ],
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _findFocusController.isLoading,
                    data: _findFocusController.prompt,
                    onTap: () {
                      _findFocusController.isLoading = true;
                      _findFocusController.update();
                      _findFocusController.onRefresh();
                    },
                  ),
                );
        });
  }

  Widget renderFocusContent() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [renderFocusTitle(), renderFocusList()],
        ),
      ),
    );
  }

  Widget renderPostList() {
    List<Widget> list = [];
    for (var i = 0; i < _findFocusController.contentList.length; i++) {
      list.add(Column(
        children: [
          Visibility(
            child: Container(
              height: 20.h,
              color: AppColors.unactive.withOpacity(0.1),
            ),
            visible: i != 0,
          ),
          GetBuilder(
            init: _findFocusController,
            builder: (_) {
              return _findFocusController.contentList.isNotEmpty
                  ? FindFocusItem(
                      findFocusContentItemModel:
                          _findFocusController.contentList[i])
                  : const SizedBox.shrink();
            },
          )
        ],
      ));
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: list,
        ),
      ),
    );
  }

  Widget renderFocusTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('you_probably_know_them'.tr + '~'),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.w),
              ),
            ),
            onPressed: () {
              _findFocusController.refreshData();
            },
            child:  Text('change'.tr))
      ],
    );
  }

  Widget renderFocusList() {
    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _findFocusController.findTopImgList.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 20.w,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return renderFocusCard(index);
        },
      ),
    );
  }

  Widget renderFocusCard(int index) {
    return GetBuilder(
      init: _findFocusController,
      initState: (_) {},
      builder: (_) {
        return Container(
          height: 300.h,
          width: 200.w,
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              border: Border.all(
                  width: 1.0, color: AppColors.unactive.withOpacity(0.2))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(75.w),
                child: NetLoadImage(
                  imageUrl: _findFocusController.findTopImgList[index].headImg,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                _findFocusController.findTopImgList[index].nickname,
                style: TextStyle(color: Colors.black, fontSize: 30.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                _findFocusController.findTopImgList[index].petBreed,
                style: TextStyle(fontSize: 24.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "已有${_findFocusController.findTopImgList[index].relationNum}关注",
                style: TextStyle(fontSize: 22.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.h,
              ),
              renderFocusBtn(
                  isFocus:
                      _findFocusController.findTopImgList[index].isRelation,
                  callBack: () {
                    _findFocusController.requestFocus(
                        attation: _findFocusController
                            .findTopImgList[index].isRelation,
                        userByid:
                            _findFocusController.findTopImgList[index].userId);
                  })
            ],
          ),
        );
      },
    );
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
}
