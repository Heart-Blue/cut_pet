import 'package:cute_pet/components/sticky_header.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/views/home/home_recommend_list.dart';
import 'package:cute_pet/views/home/home_header.dart';
import 'package:cute_pet/views/home/home_condition_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _homeController,
      initState: (_) {
      },
      builder: (_) {
        return NestedScrollView(
            controller: _homeController.scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                HomeHeader(),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                      child: TabBar(
                    controller: _tabController,
                    tabs:  [Text('recommend'.tr),Text('dynamic'.tr)],
                  )),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                HomeRecommendList(),
                HomeConditionList(),
              ],
            ));
      },
    );
  }
}
