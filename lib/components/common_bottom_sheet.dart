import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 底部弹出框
class CommonBottomSheet extends StatelessWidget {
  final List list;
  final Function(int i) callBack;
  const CommonBottomSheet(
      {Key? key, required this.list, required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: list.length * 80 + 10.h,
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 0.5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (index == list.length - 1) {
            return Column(
              children: [
                itemWidget(index),
                Container(
                  height: 10.h,
                  color: AppColors.unactive,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: Get.width,
                    height: 80.h,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.w)),
                    child: Text('cancel'.tr),
                  ),
                )
              ],
            );
          }
          return itemWidget(index);
        },
      ),
    );
  }

  itemWidget(int index) {
    return GestureDetector(
      onTap: () {
        callBack(index);
      },
      child: Container(
        width: Get.width,
        height: 80.h,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 10.w : 0),
                topRight: Radius.circular(index == 0 ? 10.w : 0),
                bottomLeft:
                    Radius.circular(index == list.length - 1 ? 10.w : 0),
                bottomRight:
                    Radius.circular(index == list.length - 1 ? 10.w : 0))),
        child: Text(
          list[index],
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
