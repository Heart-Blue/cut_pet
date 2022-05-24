import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/views/root_pages/found_page.dart';
import 'package:cute_pet/views/root_pages/home_page.dart';
import 'package:cute_pet/views/root_pages/profile_page.dart';
import 'package:cute_pet/views/root_pages/topic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // 当前选中的项
  int currentIndex = 0;
  // 底部导航数组  国际化时因为使用了final关键字，导致切换语言底部导航栏不生效，需要将其移到build中
  // final List<BottomNavigationBarItem> _bottomNavList = [
  //   BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'home'.tr),
  //   BottomNavigationBarItem(
  //       icon: const Icon(Icons.insert_invitation), label: 'found'.tr),
  //   const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
  //   BottomNavigationBarItem(
  //       icon: const Icon(Icons.chrome_reader_mode), label: 'topic'.tr),
  //   BottomNavigationBarItem(
  //       icon: const Icon(Icons.person), label: 'profile'.tr),
  // ];
  final List<IndexedStackChild> pages = [
    IndexedStackChild(child: const HomePage()),
    IndexedStackChild(child: const FoundPage()),
    IndexedStackChild(child: const SizedBox.shrink()), // 占位符
    IndexedStackChild(child: TopicPage()),
    IndexedStackChild(child: ProfilePage()),
  ];
  final _appThemeController = Get.find<AppThemeController>();

  // 底部导航栏切换
  void _onTabClick(int index) {
    if (index == 2) {
      return _onCreateMedia();
    }

    setState(() {
      currentIndex = index;
    });
  }

  // 发布按钮
  void _onCreateMedia() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProsteIndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: 'home'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.insert_invitation), label: 'found'.tr),
          const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(
              icon: const Icon(Icons.chrome_reader_mode), label: 'topic'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: 'profile'.tr),
        ],
        currentIndex: currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: _createMediaButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 发布按钮
  Widget _createMediaButton() {
    return GetBuilder(
      init: _appThemeController,
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: EdgeInsets.only(top: 95.h),
          child: Icon(
            Icons.add_circle,
            size: 80.w,
            color: AppColors.appthemeColor(_appThemeController.themeMark),
          ),
        );
      },
    );
  }
}
