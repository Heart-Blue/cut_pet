import 'package:cute_pet/components/comment_reply_input.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/utils/find_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindBottomTool extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(String text) submitAction;
  final FindActionCallBack? actionCallback;
  final bool agreeState;
  final bool collectionState;
  final String agreeCount;
  final String collectionCount;
  final Color backcolorColor;
  final Color inputBackColor;
  final Color mainColor;
  final bool showBorder;
  final AppThemeController appThemeController;

  const FindBottomTool({
    Key? key,
    required this.focusNode,
    required this.controller,
    required this.submitAction,
    this.actionCallback,
    this.agreeState = false,
    this.collectionState = false,
    this.agreeCount = '10',
    this.collectionCount = '20',
    this.backcolorColor = Colors.white,
    this.mainColor = const Color(0xff666666),
    this.inputBackColor = const Color(0xfff7f7f7),
    this.showBorder = true,
    required this.appThemeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      color: backcolorColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(
                  left: 12.w, right: 30.w, top: 7.h, bottom: 7.h),
              decoration: BoxDecoration(
                  color: inputBackColor,
                  borderRadius: BorderRadius.circular(20.w)),
              child: Text('comment_on_cutie'.tr + '...',
                  style: TextStyle(fontSize: 28.sp, color: mainColor)),
            ),
            onTap: () {
              Get.bottomSheet(CommentReplyInput(focusNode: focusNode, controller: controller,submitAction: submitAction,));
            },
          ),
          Row(
            children: <Widget>[
              bottomItem(
                  agreeState ? Icons.favorite_border : Icons.favorite,
                  agreeState
                      ? AppColors.unactive
                      : AppColors.appthemeColor(appThemeController.themeMark),
                  agreeCount,
                  0),
              SizedBox(width: 30.w),
              bottomItem(
                  collectionState ? Icons.star : Icons.star_border,
                  collectionState
                      ? AppColors.appthemeColor(appThemeController.themeMark)
                      : AppColors.unactive,
                  collectionCount,
                  1)
            ],
          )
        ],
      ),
    );
  }

  Widget bottomItem(IconData icon, Color iconColor, String number, int index) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GetBuilder(
              init: appThemeController,
              builder: (_) {
                return Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                );
              }),
          SizedBox(
            height: 5.h,
          ),
          Text(number, style: TextStyle(fontSize: 24.sp, color: iconColor))
        ],
      ),
      onTap: () {
        if (index == 0) {
          actionCallback!(FindActionType.agree);
        } else if (index == 1) {
          actionCallback!(FindActionType.collection);
        }
      },
    );
  }

}
