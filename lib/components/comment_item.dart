import 'package:cute_pet/components/comment_reply_item.dart';
import 'package:cute_pet/components/common_bottom_sheet.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/models/comment_reply_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentItem extends StatelessWidget {
  final String headImg;
  final String nickname;
  final String publishTime;
  final String commentInfo;
  final String agreeStatus;
  final int cntAgree;
  final int userId;
  final List<CommentReolyModel> commentReplyVOs;
  final Function() argeeCallBack;
  final Function(int index) replyCallBack;
  final AppThemeController appThemeController;
  const CommentItem(
      {Key? key,
      required this.headImg,
      required this.nickname,
      required this.publishTime,
      required this.commentInfo,
      required this.agreeStatus,
      required this.cntAgree,
      required this.userId,
      required this.commentReplyVOs,
      required this.argeeCallBack,
      required this.replyCallBack,
      required this.appThemeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(75.w),
            child: NetLoadImage(
              imageUrl: headImg,
              width: 75.w,
              height: 75.w,
            ),
          ),
          title: Text(
            nickname,
            style: TextStyle(fontSize: 26.sp, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            publishTime,
            style: TextStyle(fontSize: 24.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder(
                  init: appThemeController,
                  builder: (_) {
                    return InkWell(
                      onTap: argeeCallBack,
                      child: Icon(
                        agreeStatus == '0'
                            ? Icons.favorite_border
                            : Icons.favorite,
                        size: 20,
                        color: agreeStatus == '0'
                            ? AppColors.unactive
                            : AppColors.appthemeColor(
                                appThemeController.themeMark),
                      ),
                    );
                  }),
              SizedBox(width: 5.h),
              Text(cntAgree.toString(),
                  style: TextStyle(
                      fontSize: 24.sp, color: const Color(0xff666666)))
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 130.w, right: 30.w, top: 0.h, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  CommonBottomSheet(
                    list:  ['reply'.tr, 'delete'.tr],
                    callBack: replyCallBack,
                  ),
                  // backgroundColor: Colors.white,
                  enableDrag: true, //是否允许往下拖关闭bottomSheet
                  isDismissible: true,
                );
              },
              child: Text(commentInfo,
                  style: const TextStyle(color: Colors.black))),
                  Visibility(
            visible:commentReplyVOs.isNotEmpty,
            child: CommentReplyItem(
                replyLists: commentReplyVOs,
                userId: userId))
            ],
          ),
        ),
      ],
    );
  }
}
