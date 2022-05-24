import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/controllers/find_recommend_controller.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:cute_pet/views/find/find_recom_swiper.dart';
import 'package:cute_pet/views/home/home_condition_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindRecommendIndex extends StatelessWidget {
  FindRecommendIndex({Key? key}) : super(key: key);
  final _findRecommendController = Get.find<FindRecommendController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _findRecommendController,
        builder: (_) {
          return _findRecommendController.conditionList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: PullRefresher.customHeader,
                  footer: PullRefresher.customFooter,
                  controller: _findRecommendController.refreshController,
                  onRefresh: _findRecommendController.onRefresh,
                  onLoading: _findRecommendController.onLoading,
                  child: CustomScrollView(
                    slivers: [
                      renderTopicItems(),
                      renderPullList(),
                    ],
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _findRecommendController.isLoading,
                    data: _findRecommendController.prompt,
                    onTap: () {
                      _findRecommendController.isLoading = true;
                      _findRecommendController.update();
                      _findRecommendController.onRefresh();
                    },
                  ),
                );
        });
  }

  Widget renderTopicItems() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      sliver: SliverToBoxAdapter(
        child: FindTopicSwiper(
            topics: _findRecommendController.findRecommendImageList),
      ),
    );
  }

  Widget renderPullList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      sliver: SliverStaggeredGrid.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: 20.w,
        itemCount: _findRecommendController.conditionList.length,
        staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return HomeConditionItem(
              homeConditionItemModel:
                  _findRecommendController.conditionList[index]);
        },
      ),
    );
  }
}
