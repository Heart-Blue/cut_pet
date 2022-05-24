import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/topic_root_controller.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:cute_pet/views/find/find_topic_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicPage extends StatelessWidget {
  TopicPage({Key? key}) : super(key: key);
  final _topicRootController = Get.find<TopicRootController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('topic'.tr),
      ),
      body: Container(
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        alignment: Alignment.center,
        child: GetBuilder(
            init: _topicRootController,
            builder: (_) {
              return _topicRootController.contentList.isNotEmpty
                  ? SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: PullRefresher.customHeader,
                      footer: PullRefresher.customFooter,
                      controller: _topicRootController.refreshController,
                      onRefresh: _topicRootController.onRefresh,
                      onLoading: _topicRootController.onLoading,
                      child: ListView.separated(
                        itemCount: _topicRootController.contentList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 1.h,
                            color: AppColors.unactive.withOpacity(0.3),
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return FindTopicItem(
                              findTopicContentItemModel:
                                  _topicRootController.contentList[index]);
                        },
                      ),
                    )
                  : Center(
                      child: EmptyContent(
                        isLoading: _topicRootController.isLoading,
                        data: _topicRootController.prompt,
                        onTap: () {
                          _topicRootController.isLoading = true;
                          _topicRootController.update();
                          _topicRootController.onRefresh();
                        },
                      ),
                    );
            }),
      ),
    );
  }
}
