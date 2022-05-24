import 'package:cute_pet/components/sticky_header.dart';
import 'package:cute_pet/controllers/topic_index_controller.dart';
import 'package:cute_pet/views/topic/topic_hot.dart';
import 'package:cute_pet/views/topic/topic_latest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui show PlaceholderAlignment;

class TopicIndex extends StatefulWidget {
  const TopicIndex({Key? key}) : super(key: key);

  @override
  State<TopicIndex> createState() => _TopicIndexState();
}

class _TopicIndexState extends State<TopicIndex>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _topicIndexController = Get.find<TopicIndexController>();
  final result = Get.arguments;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('热门讨论'),
      ),
      body: NestedScrollView(
          controller: _topicIndexController.scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              header(),
              SliverToBoxAdapter(
                child: Divider(
                  height: 20.h,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                    child: TabBar(
                  controller: _tabController,
                  tabs: const [Text('热门'), Text('最新')],
                )),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [TopicHot(), TopicLatest()],
          )),
    );
  }

  Widget header() {
    return SliverToBoxAdapter(
        child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            result['title'],
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              haderBottemItem(
                  name: '回答', number: result['answerNum'].toString()),
              SizedBox(
                width: 50.w,
              ),
              haderBottemItem(
                  name: '阅读', number: result['questionReadNum'].toString()),
              SizedBox(
                width: 50.w,
              ),
              haderBottemItem(
                  name: '讨论', number: result['commentNum'].toString()),
            ],
          )
        ],
      ),
    ));
  }

  Widget haderBottemItem({required String name, required String number}) {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
          child: Text(name + ': ', style: const TextStyle(color: Colors.grey)),
          alignment: ui.PlaceholderAlignment.middle),
      WidgetSpan(
          child: Text(number, style: const TextStyle(color: Colors.black)),
          alignment: ui.PlaceholderAlignment.middle),
    ]));
  }
}
