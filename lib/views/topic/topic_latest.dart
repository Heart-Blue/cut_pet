import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/controllers/topic_index_controller.dart';
import 'package:cute_pet/models/topic_latest_model.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicLatest extends StatelessWidget {
  TopicLatest({Key? key}) : super(key: key);
  final _topicIndexController = Get.find<TopicIndexController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _topicIndexController,
        builder: (_) {
          return _topicIndexController.latestList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: PullRefresher.customHeader,
                  footer: PullRefresher.customFooter,
                  controller: _topicIndexController.refreshControllerLatest,
                  onRefresh: _topicIndexController.onRefreshLatest,
                  onLoading: _topicIndexController.onLoadingLatest,
                  child: ListView.separated(
                    itemCount: _topicIndexController.latestList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 2,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return hot(_topicIndexController.latestList[index]);
                    },
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _topicIndexController.isLoadingLatest,
                    data: _topicIndexController.promptLatest,
                  ),
                );
        });
  }

  Widget hot(TopicLatestItemModel topicLatestItemModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      color: Colors.white,
      child: Column(
        children: [
          header(topicLatestItemModel),
          SizedBox(
            height: 20.h,
          ),
          content(topicLatestItemModel)
        ],
      ),
    );
  }

  Widget header(TopicLatestItemModel topicLatestItemModel) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(75.w),
          child: NetLoadImage(imageUrl: topicLatestItemModel.headImg),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(topicLatestItemModel.nickname,
                style: const TextStyle(color: Colors.black)),
            SizedBox(
              height: 5.h,
            ),
            Text(
              topicLatestItemModel.createTime,
              style: TextStyle(fontSize: 24.sp),
            ),
          ],
        )
      ],
    );
  }

  Widget content(TopicLatestItemModel topicLatestItemModel) {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Text(
              topicLatestItemModel.textDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )),
        Visibility(
          visible: topicLatestItemModel.firstFile.isNotEmpty,
          child: SizedBox(
            width: 10.w,
          ),
        ),
        Visibility(
          visible: topicLatestItemModel.firstFile.isNotEmpty,
          child: Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: NetLoadImage(
                  imageUrl: topicLatestItemModel.firstFile,
                  height: 100.h,
                ),
              )),
        ),
      ],
    );
  }
}
