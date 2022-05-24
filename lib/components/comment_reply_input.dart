import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentReplyInput extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(String text) submitAction;
  const CommentReplyInput(
      {Key? key,
      required this.focusNode,
      required this.controller,
      required this.submitAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      width: Get.width,
      child: Row(
        children: [
          Expanded(
              child: TextField(
                  keyboardType: TextInputType.text,
                  focusNode: focusNode,
                  controller: controller,
                  autofocus: true,
                  style: TextStyle(fontSize: 28.sp, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.w, horizontal: 16.h),
                    hintText: 'comment_on_cutie'.tr + '...',
                    hintStyle: TextStyle(
                        fontSize: 28.sp, color: const Color(0xFF333333)),
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFFf7f7f7),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            style: BorderStyle.none, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30.w)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            style: BorderStyle.none, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30.w)),
                  ),
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      EasyLoading.showInfo(
                          'comment_messages_cannot_be_empty'.tr + '!');
                      return;
                    }
                    submitAction(value);
                    focusNode.unfocus();
                    controller.text = '';
                    Get.back();
                  })),
          InkWell(
            onTap: () {
              if (controller.text.isEmpty) {
                EasyLoading.showInfo(
                    'comment_messages_cannot_be_empty'.tr + '!');
                return;
              }
              submitAction(controller.text);
              focusNode.unfocus();
              controller.text = '';
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'send'.tr,
                style: const TextStyle(color: AppColors.active),
              ),
            ),
          )
        ],
      ),
    );
  }
}
