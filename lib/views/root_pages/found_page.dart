import 'package:cute_pet/views/find/find_focus_index.dart';
import 'package:cute_pet/views/find/find_recommend_index.dart';
import 'package:cute_pet/views/find/find_topic_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FoundPage extends StatefulWidget {
  const FoundPage({Key? key}) : super(key: key);

  @override
  State<FoundPage> createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage>
    with SingleTickerProviderStateMixin {
  List<Widget> tabViews = [
    FindFocusIndex(),
    FindRecommendIndex(),
    FindTopicIndex()
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'focus'.tr),Tab(text: 'recommend'.tr),Tab(text: 'topic'.tr)],
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xffa1abbe),
          labelStyle: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          labelPadding: EdgeInsets.symmetric(horizontal: 40.w),
        ),
        centerTitle: false,
      ),
      body: TabBarView(controller: _tabController, children: tabViews),
    );
  }
}
