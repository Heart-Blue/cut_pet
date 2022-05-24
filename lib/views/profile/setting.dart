import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/controllers/find_focus_controller.dart';
import 'package:cute_pet/controllers/find_recommend_controller.dart';
import 'package:cute_pet/controllers/find_topic_index_controller.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/controllers/profile_controller.dart';
import 'package:cute_pet/controllers/topic_root_controller.dart';
import 'package:cute_pet/models/pet_info_model.dart';
import 'package:cute_pet/models/profile_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('set'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: Get.width,
                height: 120.h,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                child: ElevatedButton(
                  child: Text(
                    'log_out'.tr,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.w),
                    ),
                  ),
                  onPressed: () {
                    _loginOut(context);
                  },
                ))
          ],
        ),
      ),
    );
  }

  void _loginOut(context) {
    SharedStorage.cleanToken();
    SharedStorage.cleanUserInfo();
    resetAppInfo();
    EasyLoading.showSuccess('${'logging_out_successfully'.tr}!');
    Future.delayed(const Duration(milliseconds: 1000), () {
      Get.back();
    });
  }

  void resetAppInfo() {
    Get.find<ProfileController>().profileInfo = ProfileInfoModel(
        user: User(),
        userinfo: Userinfo(),
        userlevel: Userlevel(),
        usermedalList: [],
        targetRule: TargetRule(),
        userMember: UserMember());
    Get.find<ProfileController>().petList = PetListModel(list: []).list;
    Get.find<ProfileController>().petInfo =
        PetItemModel(nearlyGrowPlanList: []);
    Get.find<HomeController>().onRefreshCommend();
    Get.find<HomeController>().onRefreshCondition();
    Get.find<ProfileController>().getUserToken();
    Get.find<TopicRootController>().onRefresh();
    Get.find<FindFocusController>().onRefresh();
    Get.find<FindRecommendController>().onRefresh();
    Get.find<FindTopicIndexController>().onRefresh();
  }
}
