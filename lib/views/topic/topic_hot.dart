import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/controllers/topic_index_controller.dart';
import 'package:cute_pet/models/topic_hot_model.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicHot extends StatelessWidget {
  TopicHot({Key? key}) : super(key: key);
  final _topicIndexController = Get.find<TopicIndexController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _topicIndexController,
        builder: (_) {
          return _topicIndexController.hotList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: PullRefresher.customHeader,
                  footer: PullRefresher.customFooter,
                  controller: _topicIndexController.refreshControllerHot,
                  onRefresh: _topicIndexController.onRefreshHot,
                  onLoading: _topicIndexController.onLoadingHot,
                  child: ListView.separated(
                    itemCount: _topicIndexController.hotList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 2,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return hot(_topicIndexController.hotList[index]);
                    },
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _topicIndexController.isLoadingHot,
                    data: _topicIndexController.promptHot,
                  ),
                );
        });
  }

  Widget hot(TopicHotItemModel topicHotItemModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      color: Colors.white,
      child: Column(
        children: [
          header(topicHotItemModel),
          SizedBox(
            height: 20.h,
          ),
          content(topicHotItemModel)
        ],
      ),
    );
  }

  Widget header(TopicHotItemModel topicHotItemModel) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(75.w),
          child: NetLoadImage(imageUrl: topicHotItemModel.headImg),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(topicHotItemModel.nickname,
                style: const TextStyle(color: Colors.black)),
            SizedBox(
              height: 5.h,
            ),
            Text(
              topicHotItemModel.createTime,
              style: TextStyle(fontSize: 24.sp),
            ),
          ],
        )
      ],
    );
  }

  Widget content(TopicHotItemModel topicHotItemModel) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Text(
              topicHotItemModel.textDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )),
        Visibility(
          visible: topicHotItemModel.firstFile.isNotEmpty,
          child: SizedBox(
            width: 10.w,
          ),
        ),
        Visibility(
          visible: topicHotItemModel.firstFile.isNotEmpty,
          child: Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: NetLoadImage(
                  imageUrl: topicHotItemModel.firstFile,
                  height: 100.h,
                ),
              )),
        ),
      ],
    );
  }
}
