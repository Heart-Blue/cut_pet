import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/topic_pet_controller.dart';
import 'package:cute_pet/models/topic_pet_model.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicPetMore extends StatelessWidget {
  TopicPetMore({Key? key}) : super(key: key);
  final _topicPetController = Get.find<TopicPetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pet_list'.tr),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: GetBuilder(
          init: _topicPetController,
          initState: (_) {},
          builder: (_) {
            return _topicPetController.petList.isNotEmpty
                ? SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: PullRefresher.customHeader,
                    footer: PullRefresher.customFooter,
                    controller: _topicPetController.refreshController,
                    onRefresh: _topicPetController.onRefresh,
                    onLoading: _topicPetController.onLoading,
                    child: ListView.separated(
                      itemCount: _topicPetController.petList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 30.h,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return renderCard(_topicPetController.petList[index]);
                      },
                    ),
                  )
                : Center(
                    child: EmptyContent(
                      isLoading: _topicPetController.isLoading,
                      data: _topicPetController.prompt,
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget renderCard(TopicPetItemModel topicPetItemModel) {
    return InkWell(
      onTap: () {
        Get.toNamed('/topicDetail',
            arguments: {'tribeId': topicPetItemModel.tribeId});
      },
      child: SizedBox(
        height: 200.w,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: NetLoadImage(
                  imageUrl: topicPetItemModel.headImg,
                  width: 200.w,
                  height: 200.w,
                )),
            SizedBox(
              width: 30.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topicPetItemModel.tribeName,
                          style: const TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          topicPetItemModel.tribeDescription,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 35.w,
                          color: AppColors.unactive,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "${topicPetItemModel.userCount}关注",
                          style: TextStyle(fontSize: 26.sp),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
