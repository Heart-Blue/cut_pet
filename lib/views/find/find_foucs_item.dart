import 'package:cute_pet/components/app_comment.dart';
import 'package:cute_pet/components/gallery_photo_view.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/find_focus_controller.dart';
import 'package:cute_pet/models/find_focus_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindFocusItem extends StatelessWidget {
  final FindFocusContentItemModel findFocusContentItemModel;
  FindFocusItem({Key? key, required this.findFocusContentItemModel})
      : super(key: key);
  final _findFocusController = Get.find<FindFocusController>();
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/homeConditionDetail',arguments: {"messageId":findFocusContentItemModel.messageId});
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppComment.header(
                headImg: findFocusContentItemModel.userInfo.headImg,
                nickname: findFocusContentItemModel.userInfo.nickname,
                createTime: findFocusContentItemModel.createTime,
                followStatus: findFocusContentItemModel.followStatus,
                callBack: () {
                  _findFocusController.requestFocus(
                      attation: findFocusContentItemModel.followStatus == '关注',
                      userByid: findFocusContentItemModel.userId,isContent: true);
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  renderNav(),
                  renderImage(),
                  renderMap(),
                  renderCommonList(),
                  renderBottom()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderNav() {
    return Visibility(
      child: Text(
        findFocusContentItemModel.messageInfo,
        style: const TextStyle(color: Colors.black),
      ),
      visible: findFocusContentItemModel.messageInfo.isNotEmpty,
    );
  }

  Widget renderImage() {
    List<Widget> widgetList = [];
    List<String> images =
        findFocusContentItemModel.fileList.map((e) => e.fileUrl).toList();
    for (var i = 0; i < findFocusContentItemModel.fileList.length; i++) {
      widgetList.add(ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: GestureDetector(
          onTap: () {
            //查看大图
            Navigator.of(Get.context!)
                .push(PageRouteBuilder(pageBuilder: (ctx, animal1, animal2) {
              return FadeTransition(
                  opacity: animal1,
                  child: PhotoViewGalleryScreen(
                    images: images, //传入图片list
                    index: i, //传入当前点击的图片的index
                  ));
            }));
          },
          child: NetLoadImage(
            imageUrl: findFocusContentItemModel.fileList[i].fileUrl,
            width: 222.w,
            height: 222.w,
          ),
        ),
      ));
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Wrap(
        spacing: 20.w,
        runSpacing: 20.h,
        children: widgetList,
      ),
    );
  }

  Widget renderMap() {
    return Column(
      children: [
        Visibility(
            visible: findFocusContentItemModel.userInfo.city.isNotEmpty,
            child: Row(
              children: [
                const Icon(Icons.location_on,
                    size: 18, color: Color(0xff666666)),
                SizedBox(
                  width: 10.w,
                ),
                Text(findFocusContentItemModel.userInfo.city),
              ],
            )),
        SizedBox(
          height: 10.h,
        ),
        const Divider()
      ],
    );
  }

  Widget renderBottom() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderBottomItem(
              icon: findFocusContentItemModel.agreeStatus == '0'
                  ? Icons.favorite_border
                  : Icons.favorite,
              iconColor: findFocusContentItemModel.agreeStatus == '0'
                  ? AppColors.unactive
                  : AppColors.appthemeColor(_appThemeController.themeMark),
              number: findFocusContentItemModel.cntAgree.toString(),
              callBack: () {
                _findFocusController
                    .requestAgree(findFocusContentItemModel.agreeStatus == '0',messageId: findFocusContentItemModel.messageId);
              }),
          renderBottomItem(
              icon: Icons.message,
              iconColor: AppColors.unactive,
              number: findFocusContentItemModel.cntComment.toString(),
              callBack: () {}),
          renderBottomItem(
              icon: Icons.share,
              iconColor: AppColors.unactive,
              number: '',
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
          GetBuilder(
              init: _appThemeController,
              builder: (_) {
                return Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                );
              }),
          SizedBox(width: 5.h),
          Text(number,
              style: TextStyle(fontSize: 24.sp, color: const Color(0xff666666)))
        ],
      ),
      onTap: callBack,
    );
  }

  Widget renderCommonList() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: const Color(0xfff7f7f7),
          borderRadius: BorderRadius.circular(20.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderCommonChildren(),
      ),
    );
  }

  List<Widget> renderCommonChildren() {
    List<Widget> commonWidgets = [];
    for (var i = 0; i < findFocusContentItemModel.commentList.length; i++) {
      if (i < 3) {
        commonWidgets.add(Text.rich(
          TextSpan(children: <InlineSpan>[
            WidgetSpan(
                child: Text(
                    findFocusContentItemModel.commentList[i].nickname + ': ',
                    style: TextStyle(
                        fontSize: 26.sp, color: const Color(0xff526e94))),
                alignment: PlaceholderAlignment.middle),
            ...findFocusContentItemModel.commentList[i].commentInfo.runes
                .map((rune) {
              return WidgetSpan(
                  child: Text(String.fromCharCode(rune),
                      style: TextStyle(
                          fontSize: 26.sp, color: const Color(0xff666666))),
                  alignment: PlaceholderAlignment.middle);
            }).toList()
          ]),
          softWrap: true,
        ));
      } else {}
    }
    if (findFocusContentItemModel.commentList.length >= 3) {
      commonWidgets.add(Text.rich(
        TextSpan(children: <InlineSpan>[
          WidgetSpan(
              child: Text('check_out_more_comments'.tr,
                  style: TextStyle(
                      fontSize: 26.sp, color: const Color(0xff526e94))),
              alignment: PlaceholderAlignment.middle),
          const WidgetSpan(
              child: Icon(Icons.keyboard_arrow_right,
                  size: 15, color: Color(0xff526e94)),
              alignment: PlaceholderAlignment.middle)
        ]),
      ));
    }
    return commonWidgets;
  }
}
