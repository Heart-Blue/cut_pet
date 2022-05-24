import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/models/home_condition_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeConditionItem extends StatelessWidget {
  HomeConditionItem({Key? key, required this.homeConditionItemModel})
      : super(key: key);
  final HomeConditionItemModel homeConditionItemModel;
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(homeConditionItemModel.messageType == '1') {
          Get.toNamed('/findVideoList',arguments: {"messageId":homeConditionItemModel.messageId});
        }else {
          Get.toNamed('/homeConditionDetail',arguments: {"messageId":homeConditionItemModel.messageId});
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            renderNav(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  renderHeaderImage(),
                  renderOtherInfo(),
                  renderNumberItem()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderNav() {
    return Stack(
      alignment: Alignment.center,
      children: [
        NetLoadImage(
          imageUrl: homeConditionItemModel.videoCover,
          width: Get.width / 2,
          height: Get.width / 2 + (homeConditionItemModel.messageType == '1' ? 200.h : 0),
        ),
        homeConditionItemModel.messageType == '1' ? Image.asset('assets/images/video_play.png',
            width: 55.w, height: 55.w) : const SizedBox.shrink(),
      ],
    );
  }

  Widget renderHeaderImage() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: NetLoadImage(
            imageUrl: homeConditionItemModel.headImg,
            width: 50.w,
            height: 50.w,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(homeConditionItemModel.nickname)
      ],
    );
  }

  Widget renderOtherInfo() {
    List<Widget> itemList = [];
    if (homeConditionItemModel.labelName.isNotEmpty) {
      itemList.add(renderTopicItem());
    }
    if (homeConditionItemModel.messageInfo.isNotEmpty) {
      itemList.add(renderMessageItem());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: itemList,
    );
  }

  Widget renderTopicItem() {
    return Container(
      color: AppColors.unactive.withOpacity(0.05),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: GetBuilder(
        init: _appThemeController,
        initState: (_) {},
        builder: (_) {
          return Text(
            "#${homeConditionItemModel.labelName}",
            style: TextStyle(
                fontSize: 22.sp,
                color: AppColors.appthemeColor(_appThemeController.themeMark)),
          );
        },
      ),
    );
  }

  Widget renderMessageItem() {
    return Text(homeConditionItemModel.messageInfo,
        style: TextStyle(
          fontSize: 24.sp,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis);
  }

  Widget renderNumberItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderBottomItem(
              homeConditionItemModel.agreeStatus == '1'
                  ? Icons.favorite
                  : Icons.favorite_border,
              homeConditionItemModel.agreeStatus == '1'
                  ? AppColors.appthemeColor(_appThemeController.themeMark)
                  : AppColors.unactive,
              homeConditionItemModel.messageAgreeNum),
          renderBottomItem(
            Icons.remove_red_eye,
            AppColors.unactive,
            homeConditionItemModel.messageReadNum,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget renderBottomItem(IconData icon, Color iconColor, String number,
      {TextAlign textAlign = TextAlign.left}) {
    return Row(
      children: [
        GetBuilder(init: _appThemeController,builder: (_) {
          return Icon(icon, color: iconColor, size: 28.sp);
        }),
        SizedBox(width: 10.w),
        Text(number,
            style: TextStyle(
              fontSize: 24.sp,
            ),
            textAlign: textAlign),
      ],
    );
  }
}
