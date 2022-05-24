import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:cute_pet/views/home/home_recommend_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRecommendList extends StatelessWidget {
  HomeRecommendList({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _homeController,
        builder: (_) {
          return _homeController.petList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: PullRefresher.customHeader,
                  footer: PullRefresher.customFooter,
                  controller: _homeController.refreshRecommendController,
                  onRefresh: _homeController.onRefreshCommend,
                  onLoading: _homeController.onLoadingCommend,
                  child: StaggeredGridView.countBuilder(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 20.w,
                    itemCount: _homeController.petList.length,
                    staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      return HomeRecommendItem(
                          petCardItemModel: _homeController.petList[index]);
                    },
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _homeController.isLoadingRecommend,
                    data: _homeController.promptRecommend,
                    onTap: () {
                      _homeController.isLoadingRecommend = true;
                      _homeController.update();
                      _homeController.onRefreshCommend();
                    },
                  ),
                );
        });
  }
}
