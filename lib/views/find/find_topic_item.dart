import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/find_topic_index_controller.dart';
import 'package:cute_pet/models/find_topic_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindTopicItem extends StatelessWidget {
  final FindTopicContentItemModel findTopicContentItemModel;
  FindTopicItem({Key? key, required this.findTopicContentItemModel})
      : super(key: key);
  final _findTopicIndexController = Get.find<FindTopicIndexController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/topicIndex', arguments: {
          'questionId': findTopicContentItemModel.questionId,
          'title': findTopicContentItemModel.title,
          'answerNum': findTopicContentItemModel.answerNum,
          'questionReadNum': findTopicContentItemModel.questionReadNum,
          'commentNum': findTopicContentItemModel.commentNum,
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          title(),
          nav(),
          content(),
          renderBottom()
        ],
      ),
    );
  }

  Widget title() {
    return Text(
      findTopicContentItemModel.title,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 30.sp, color: Colors.black),
    );
  }

  Widget nav() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40.w),
          child: NetLoadImage(
            imageUrl: findTopicContentItemModel.headImg,
            width: 40.w,
            height: 40.w,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(findTopicContentItemModel.nickname),
        SizedBox(
          width: 10.w,
        ),
        GetBuilder<AppThemeController>(
          init: AppThemeController(),
          initState: (_) {},
          builder: (_) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                border: Border.all(
                    width: 1.0, color: AppColors.appthemeColor(_.themeMark)),
              ),
              child: Text(
                findTopicContentItemModel.tribeName,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.appthemeColor(_.themeMark)),
              ),
            );
          },
        )
      ],
    );
  }

  Widget content() {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Text(
              findTopicContentItemModel.firstAnswer,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            )),
        SizedBox(
          width: 10.w,
        ),
        Visibility(
          visible: findTopicContentItemModel.firstFile.isNotEmpty,
          child: Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: NetLoadImage(
                  imageUrl: findTopicContentItemModel.firstFile,
                  height: 100.h,
                ),
              )),
        )
      ],
    );
  }

  Widget renderBottom() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GetBuilder<AppThemeController>(
              init: AppThemeController(),
              builder: (_) {
                return renderBottomItem(
                    icon: findTopicContentItemModel.agreeStatus == '1'
                        ? Icons.favorite_border
                        : Icons.favorite,
                    iconColor: findTopicContentItemModel.agreeStatus == '1'
                        ? AppColors.unactive
                        : AppColors.appthemeColor(_.themeMark),
                    number: findTopicContentItemModel.agreeNum.toString(),
                    callBack: () {
                      _findTopicIndexController.requestAgree(
                          findTopicContentItemModel.agreeStatus == '1',
                          answerId: findTopicContentItemModel.answerId);
                    });
              }),
          SizedBox(
            width: 100.w,
          ),
          renderBottomItem(
              icon: Icons.message,
              iconColor: AppColors.unactive,
              number: findTopicContentItemModel.commentNum.toString(),
              callBack: () {}),
        ],
      ),
    );
  }

  Widget renderBottomItem(
      {required IconData icon,
      required Color iconColor,
      required String number,
      required Function() callBack}) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
          SizedBox(width: 5.h),
          Text(number,
              style: TextStyle(fontSize: 24.sp, color: const Color(0xff666666)))
        ],
      ),
      onTap: callBack,
    );
  }
}
