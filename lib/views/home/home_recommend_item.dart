import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/models/pet_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeRecommendItem extends StatelessWidget {
  HomeRecommendItem({Key? key, required this.petCardItemModel}) : super(key: key);
  final PetCardItemModel petCardItemModel;
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/homeRecommendDetail',arguments: {"trialReportId": petCardItemModel.trialReportId});
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetLoadImage(
              imageUrl: petCardItemModel.fileUrl,
              width: Get.width / 2,
              height: Get.width / 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
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

  Widget renderHeaderImage() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.w),
          child: NetLoadImage(
            imageUrl: petCardItemModel.headImg,
            width: 50.w,
            height: 50.w,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(petCardItemModel.nickname)
      ],
    );
  }

  Widget renderOtherInfo() {
    List<Widget> itemList = [];
    if (petCardItemModel.labelName.isNotEmpty) {
      itemList.add(renderTopicItem());
    }
    if (petCardItemModel.messageInfo.isNotEmpty) {
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
            "#${petCardItemModel.labelName}",
            style: TextStyle(
                fontSize: 22.sp,
                color: AppColors.appthemeColor(_appThemeController.themeMark)),
          );
        },
      ),
    );
  }

  Widget renderMessageItem() {
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0,
                  color:
                      AppColors.appthemeColor(_appThemeController.themeMark))),
          child: Text(
            '种草',
            style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.appthemeColor(_appThemeController.themeMark)),
          ),
        )),
        TextSpan(
            text: petCardItemModel.messageInfo,
            style: TextStyle(
              fontSize: 24.sp,
            ))
      ]),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget renderNumberItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderBottomItem(
            petCardItemModel.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
            petCardItemModel.agreeStatus == '1' ? AppColors.appthemeColor(_appThemeController.themeMark) : AppColors.unactive,
            petCardItemModel.messageAgreenum
          ),
          renderBottomItem(
          Icons.remove_red_eye, 
          AppColors.unactive, 
          petCardItemModel.messageCommentnum, 
          textAlign: TextAlign.right,
        ),
        ],
      ),
    );
  }

  Widget renderBottomItem(IconData icon, Color iconColor, String number,{TextAlign textAlign = TextAlign.left}) {
    return Row(
      children: [
        GetBuilder(init: _appThemeController,builder: (_) {
          return Icon(icon, color: iconColor, size: 28.sp);
        }),
        SizedBox(width: 10.w),
        Text(number, style: TextStyle(fontSize: 24.sp,), textAlign: textAlign),
      ],
    );
  }
}
