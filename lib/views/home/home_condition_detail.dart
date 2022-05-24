import 'package:cute_pet/components/app_comment.dart';
import 'package:cute_pet/components/comment_item.dart';
import 'package:cute_pet/components/comment_reply_input.dart';
import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/find_bottom_tool.dart';
import 'package:cute_pet/components/gallery_photo_view.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/home_condition_detail_controller.dart';
import 'package:cute_pet/utils/find_config.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeConditionDetail extends StatelessWidget {
  HomeConditionDetail({Key? key}) : super(key: key);
  final _homeConditionDetailController =
      Get.find<HomeConditionDetailController>();
  final _appThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _homeConditionDetailController,
        builder: (_) {
          return Scaffold(
              appBar: AppBar(
                title: Text('dynamic_details'.tr),
              ),
              body: _homeConditionDetailController
                      .homeConditionDetailModel.nickName.isNotEmpty
                  ? renderBody()
                  : Center(
                      child: EmptyContent(
                        data: _homeConditionDetailController.prompt,
                        isLoading: _homeConditionDetailController.isLoading,
                      ),
                    ));
        });
  }

  Widget renderBody() {
    return Container(
      color: AppColors.page,
      height: Get.height,
      child: Column(
        children: [
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: PullRefresher.customHeader,
              footer: PullRefresher.customFooter,
              controller: _homeConditionDetailController.refreshController,
              onRefresh: _homeConditionDetailController.onRefresh,
              onLoading: _homeConditionDetailController.onLoading,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      child: AppComment.header(
                          headImg: _homeConditionDetailController
                              .homeConditionDetailModel.headImg,
                          nickname: _homeConditionDetailController
                              .homeConditionDetailModel.nickName,
                          createTime: _homeConditionDetailController
                              .homeConditionDetailModel.createTime,
                          followStatus: _homeConditionDetailController
                              .homeConditionDetailModel.followStatus,
                          callBack: () {
                            _homeConditionDetailController.requestFocus(
                                attation: _homeConditionDetailController
                                        .homeConditionDetailModel
                                        .followStatus ==
                                    '关注',
                                userByid: _homeConditionDetailController
                                    .homeConditionDetailModel.userId);
                          }),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          renderNav(),
                          renderImage(),
                          renderMap(),
                          renderBottom(),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: renderComment())
                ],
              ),
            ),
          ),
          rendeFooter()
        ],
      ),
    );
  }

  Widget renderNav() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppComment.themeTitle(
            labelName: _homeConditionDetailController
                .homeConditionDetailModel.labelName,
            appThemeController: _appThemeController),
        SizedBox(
          height: 10.h,
        ),
        Text(
          _homeConditionDetailController.homeConditionDetailModel.messageInfo,
          style: const TextStyle(color: Colors.black),
        )
      ],
    );
  }

  Widget renderImage() {
    List<Widget> widgetList = [];
    List<String> images = _homeConditionDetailController
        .homeConditionDetailModel.files
        .map((e) => e.fileUrl)
        .toList();
    for (var i = 0;
        i <
            _homeConditionDetailController
                .homeConditionDetailModel.files.length;
        i++) {
      widgetList.add(ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: GestureDetector(
          onTap: () {
            //查看大图
            Navigator.of(Get.context!).push(PageRouteBuilder(
                // transitionDuration: Duration(seconds: 1),
                pageBuilder: (ctx, animal1, animal2) {
              return FadeTransition(
                  opacity: animal1,
                  child: PhotoViewGalleryScreen(
                    images: images, //传入图片list
                    index: i, //传入当前点击的图片的index
                  ));
            }));
          },
          child: NetLoadImage(
            imageUrl: _homeConditionDetailController
                .homeConditionDetailModel.files[i].fileUrl,
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
            visible: _homeConditionDetailController
                .homeConditionDetailModel.city.isNotEmpty,
            child: Row(
              children: [
                const Icon(Icons.location_on,
                    size: 18, color: Color(0xff666666)),
                SizedBox(
                  width: 10.w,
                ),
                Text(_homeConditionDetailController
                    .homeConditionDetailModel.city),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        renderBottomItem(
            icon: _homeConditionDetailController
                        .homeConditionDetailModel.agreeStatus ==
                    '0'
                ? Icons.favorite_border
                : Icons.favorite,
            iconColor: _homeConditionDetailController
                        .homeConditionDetailModel.agreeStatus ==
                    '0'
                ? AppColors.unactive
                : AppColors.appthemeColor(_appThemeController.themeMark),
            number: _homeConditionDetailController
                .homeConditionDetailModel.cntAgree
                .toString(),
            callBack: () {
              _homeConditionDetailController.requestAgree(
                  _homeConditionDetailController
                          .homeConditionDetailModel.agreeStatus ==
                      '0');
            }),
        renderBottomItem(
            icon: _homeConditionDetailController
                        .homeConditionDetailModel.collectionsStatus ==
                    '1'
                ? Icons.star
                : Icons.star_border,
            iconColor: _homeConditionDetailController
                        .homeConditionDetailModel.collectionsStatus ==
                    '1'
                ? AppColors.appthemeColor(_appThemeController.themeMark)
                : AppColors.unactive,
            number: _homeConditionDetailController
                .homeConditionDetailModel.collectionNum,
            callBack: () {
              _homeConditionDetailController.requestCollection(
                  _homeConditionDetailController
                          .homeConditionDetailModel.collectionsStatus ==
                      '1');
            }),
        renderBottomItem(
            icon: Icons.message,
            iconColor: AppColors.unactive,
            number: _homeConditionDetailController
                .homeConditionDetailModel.commentNum,
            callBack: () {}),
        renderBottomItem(
            icon: Icons.share,
            iconColor: AppColors.unactive,
            number: '',
            callBack: () {}),
      ],
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

  Widget rendeFooter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: Get.width,
      color: Colors.white,
      child: FindBottomTool(
        focusNode: _homeConditionDetailController.focusNode,
        controller: _homeConditionDetailController.editController,
        submitAction: (text) =>
            {_homeConditionDetailController.requestComment(commentInfo: text)},
        appThemeController: _appThemeController,
        agreeState: _homeConditionDetailController
                .homeConditionDetailModel.agreeStatus ==
            '0',
        collectionState: _homeConditionDetailController
                .homeConditionDetailModel.collectionsStatus ==
            '1',
        agreeCount:
            '${_homeConditionDetailController.homeConditionDetailModel.cntAgree}',
        collectionCount: _homeConditionDetailController
            .homeConditionDetailModel.collectionNum,
        actionCallback: (type) {
          if (type == FindActionType.agree) {
            _homeConditionDetailController.requestAgree(
                _homeConditionDetailController
                        .homeConditionDetailModel.agreeStatus ==
                    '0');
          } else if (type == FindActionType.collection) {
            _homeConditionDetailController.requestCollection(
                _homeConditionDetailController
                        .homeConditionDetailModel.collectionsStatus ==
                    '1');
          }
        },
      ),
    );
  }

  Widget renderComment() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20.h),
      child: ListView.separated(
          shrinkWrap: true, //范围内进行包裹（内容多高ListView就多高）
          physics: const NeverScrollableScrollPhysics(), //禁止滚动
          itemCount: _homeConditionDetailController.commentList.length,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              children: [
                CommentItem(
                  headImg:
                      _homeConditionDetailController.commentList[i].headImg,
                  nickname:
                      _homeConditionDetailController.commentList[i].nickname,
                  publishTime:
                      _homeConditionDetailController.commentList[i].publishTime,
                  commentInfo:
                      _homeConditionDetailController.commentList[i].commentInfo,
                  agreeStatus:
                      _homeConditionDetailController.commentList[i].agreeStatus,
                  cntAgree:
                      _homeConditionDetailController.commentList[i].cntAgree,
                  argeeCallBack: () {
                    _homeConditionDetailController.requestAgree(
                        _homeConditionDetailController
                                .commentList[i].agreeStatus ==
                            '0',
                        commentId: _homeConditionDetailController
                            .commentList[i].commentId);
                  },
                  replyCallBack: (int index) {
                    Get.back();
                    if (index == 0) {
                      Get.bottomSheet(CommentReplyInput(
                          focusNode: _homeConditionDetailController.focusNode,
                          controller:
                              _homeConditionDetailController.editController,
                          submitAction: (text) {
                            _homeConditionDetailController.replyComment(
                                commentInfo: text,
                                commentId: _homeConditionDetailController
                                    .commentList[i].commentId,
                                beReplyedUserId: _homeConditionDetailController
                                    .commentList[i].userId);
                          }));
                    } else if (index == 1) {
                      _homeConditionDetailController.deleteComment(
                          commentId: _homeConditionDetailController
                              .commentList[i].commentId);
                    }
                  },
                  appThemeController: _appThemeController,
                  userId: _homeConditionDetailController.commentList[i].userId,
                  commentReplyVOs: _homeConditionDetailController
                      .commentList[i].commentReplyVOs,
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int i) {
            return const Divider(
              thickness: 0.8,
            );
          }),
    );
  }
}
