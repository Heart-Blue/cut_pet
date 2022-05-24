import 'package:cute_pet/components/app_comment.dart';
import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/home_recommend_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class HomeRecommendDetail extends StatelessWidget {
  HomeRecommendDetail({Key? key}) : super(key: key);
  final _homeRecommendDetailController =
      Get.find<HomeRecommendDetailController>();
  final _appThemeController = Get.find<AppThemeController>();
  final double spaceWidth = 20.w;
  final double spaceHeight = 20.h;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _homeRecommendDetailController,
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share))
            ],
          ),
          body: _homeRecommendDetailController
                  .homeRecommendDetailModel.reportTitle.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppComment.header(
                          headImg: _homeRecommendDetailController
                              .homeRecommendDetailModel.headImg,
                          nickname: _homeRecommendDetailController
                              .homeRecommendDetailModel.nickname,
                          createTime: _homeRecommendDetailController
                              .homeRecommendDetailModel.createTime,
                          followStatus: _homeRecommendDetailController
                              .homeRecommendDetailModel.followStatus,
                          callBack: () {}),
                      _titleWidget(),
                      _renderImageList(),
                      _renderMessageItem(),
                      _renderBottomItem()
                    ],
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _homeRecommendDetailController.isLoading,
                    data: _homeRecommendDetailController.prompt,
                  ),
                ),
        );
      },
    );
  }

  Widget _titleWidget() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: spaceWidth, vertical: spaceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _homeRecommendDetailController.homeRecommendDetailModel.reportTitle,
            style: TextStyle(fontSize: 32.sp, color: Colors.black),
          ),
          SizedBox(
            height: 20.h,
          ),
          AppComment.themeTitle(
              appThemeController: _appThemeController,
              labelName: _homeRecommendDetailController
                  .homeRecommendDetailModel.labelName),
        ],
      ),
    );
  }

  Widget _renderImageList() {
    return SizedBox(
      height: 300.h,
      child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return NetLoadImage(
                imageUrl: _homeRecommendDetailController
                    .homeRecommendDetailModel.fileList[index].fileUrl);
          },
          pagination: const SwiperPagination(),
          autoplay: true,
          loop: false,
          itemCount: _homeRecommendDetailController
              .homeRecommendDetailModel.fileList.length),
    );
  }

  Widget _renderMessageItem() {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: spaceHeight, horizontal: spaceWidth),
      child: HtmlWidget(
        _homeRecommendDetailController.homeRecommendDetailModel.h5MessageInfo,
        textStyle: TextStyle(fontSize: 30.sp),
      ),
      // child: WebView(
      //   initialUrl: _homeRecommendDetailController.homeRecommendDetailModel.h5MessageInfo,
      // )
    );
  }

  Widget _renderBottomItem() {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: spaceHeight, horizontal: spaceWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Row(
              children: [
                GetBuilder(
                  init: _appThemeController,
                  builder: (_) {
                    return Icon(
                        _homeRecommendDetailController
                                    .homeRecommendDetailModel.agreeStatus ==
                                '0'
                            ? Icons.favorite_border
                            : Icons.favorite,
                        color: AppColors.appthemeColor(
                            _appThemeController.themeMark));
                  },
                ),
                SizedBox(width: 10.w),
                Text(
                    _homeRecommendDetailController
                        .homeRecommendDetailModel.messageAgreenum,
                    style:
                        TextStyle(fontSize: 28.sp, color: AppColors.unactive))
              ],
            ),
            onTap: () {
              _homeRecommendDetailController.loadAgree(int.parse(
                  _homeRecommendDetailController
                      .homeRecommendDetailModel.agreeStatus));
            },
          ),
          GestureDetector(
            child: Row(
              children: [
                GetBuilder(
                  init: _appThemeController,
                  builder: (_) {
                    return Icon(
                        _homeRecommendDetailController.homeRecommendDetailModel
                                    .collectionStatus ==
                                '1'
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.appthemeColor(
                            _appThemeController.themeMark));
                  },
                ),
                SizedBox(width: 10.w),
                Text(
                    _homeRecommendDetailController
                        .homeRecommendDetailModel.collectionCount,
                    style:
                        TextStyle(fontSize: 28.sp, color: AppColors.unactive))
              ],
            ),
            onTap: () {
              _homeRecommendDetailController.loadCollection(int.parse(
                  _homeRecommendDetailController
                      .homeRecommendDetailModel.collectionStatus));
            },
          ),
        ],
      ),
    );
  }
}
