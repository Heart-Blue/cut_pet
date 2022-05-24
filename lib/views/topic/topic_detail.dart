import 'package:cute_pet/components/common_bottom_sheet.dart';
import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/components/sticky_header.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/topic_pet_detail_controller.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:cute_pet/views/find/find_topic_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicDetail extends StatelessWidget {
  TopicDetail({Key? key}) : super(key: key);
  final _topicPetDetailController = Get.find<TopicPetDetailController>();
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _topicPetDetailController,
        initState: (val) {
          _topicPetDetailController.loadQuestionList();
          _topicPetDetailController.loadTribeInfo();
        },
        builder: (_) {
          return _topicPetDetailController.discussList.isNotEmpty
              ? Scaffold(
                  appBar: AppBar(
                    title: Text(_topicPetDetailController.petInfo.tribeName),
                  ),
                  body: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: PullRefresher.customHeader,
                    footer: PullRefresher.customFooter,
                    controller: _topicPetDetailController.refreshController,
                    onRefresh: _topicPetDetailController.onRefresh,
                    onLoading: _topicPetDetailController.onLoading,
                    child: CustomScrollView(
                      slivers: [
                        header(),
                        nav(),
                        content(),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _topicPetDetailController.isLoading,
                    data: _topicPetDetailController.prompt,
                  ),
                );
        });
  }

  Widget header() {
    return SliverToBoxAdapter(
      child: GetBuilder(
        init: _appThemeController,
        initState: (_) {},
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            height: 200.h,
            color: AppColors.appthemeColor(_appThemeController.themeMark),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: NetLoadImage(
                    imageUrl: _topicPetDetailController.petInfo.headImg,
                    width: 200.w,
                    height: 200.w,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _topicPetDetailController.petInfo.tribeName,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 32.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "犬种: ${_topicPetDetailController.petInfo.dogBreed}",
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _topicPetDetailController.petInfo.groupName,
                          style: const TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "${_topicPetDetailController.petInfo.tribeUserCount}人关注",
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget nav() {
    return SliverPersistentHeader(
        pinned: true,
        delegate: StickyChildDelegate(
            maxHeight: 80.h,
            minHeight: 80.h,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.page,
                  border: Border(
                      bottom: BorderSide(
                          width: 2.0,
                          color: AppColors.unactive.withOpacity(0.2)))),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_topicPetDetailController.discussList.length}个讨论",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        CommonBottomSheet(
                          list: ['hot'.tr, 'all_question'.tr],
                          callBack: (val) {
                            if (_topicPetDetailController.orderType ==
                                val + 1) {
                              return Get.back();
                            }
                            _topicPetDetailController.orderType = val + 1;
                            _topicPetDetailController.onRefresh();
                            _topicPetDetailController.update();
                            Get.back();
                          },
                        ),
                        isDismissible: true,
                      );
                    },
                    child: Row(
                      children: [
                        Text(_topicPetDetailController.orderType == 1
                            ? 'hot'.tr
                            : 'all_question'.tr),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          Icons.sort,
                          color: AppColors.unactive,
                          size: 35.w,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget content() {
    return SliverToBoxAdapter(
      child: ListView.separated(
          shrinkWrap: true, //范围内进行包裹（内容多高ListView就多高）
          physics: const NeverScrollableScrollPhysics(), //禁止滚动
          itemCount: _topicPetDetailController.discussList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1.h,
              color: AppColors.unactive.withOpacity(0.3),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: FindTopicItem(
                    findTopicContentItemModel:
                        _topicPetDetailController.discussList[index]));
          }),
    );
  }
}
