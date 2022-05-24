import 'package:cute_pet/components/empty_content.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/utils/pull_refresher.dart';
import 'package:cute_pet/views/home/home_condition_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeConditionList extends StatelessWidget {
  HomeConditionList({Key? key}) : super(key: key);
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _homeController,
        builder: (_) {
          return _homeController.conditionList.isNotEmpty
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: PullRefresher.customHeader,
                  footer: PullRefresher.customFooter,
                  controller: _homeController.refreshConditionController,
                  onRefresh: _homeController.onRefreshCondition,
                  onLoading: _homeController.onLoadingCondition,
                  child: StaggeredGridView.countBuilder(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 20.w,
                    itemCount: _homeController.conditionList.length,
                    staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      return HomeConditionItem(
                          homeConditionItemModel:
                              _homeController.conditionList[index]);
                    },
                  ),
                )
              : Center(
                  child: EmptyContent(
                    isLoading: _homeController.isLoadingCondition,
                    data: _homeController.promptCondition,
                    onTap: () {
                      _homeController.isLoadingCondition = true;
                      _homeController.update();
                      _homeController.onRefreshCondition();
                    },
                  ),
                );
        });
  }
}
