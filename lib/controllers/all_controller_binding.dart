import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/find_focus_controller.dart';
import 'package:cute_pet/controllers/find_recommend_controller.dart';
import 'package:cute_pet/controllers/find_topic_index_controller.dart';
import 'package:cute_pet/controllers/home_condition_detail_controller.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/controllers/home_recommend_detail_controller.dart';
import 'package:cute_pet/controllers/home_video_detail_controller.dart';
import 'package:cute_pet/controllers/login_controller.dart';
import 'package:cute_pet/controllers/profile_controller.dart';
import 'package:cute_pet/controllers/topic_index_controller.dart';
import 'package:cute_pet/controllers/topic_pet_controller.dart';
import 'package:cute_pet/controllers/topic_pet_detail_controller.dart';
import 'package:cute_pet/controllers/topic_root_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AppThemeController>(() => AppThemeController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TopicRootController>(() => TopicRootController());
    Get.lazyPut<HomeVideoDetailController>(() => HomeVideoDetailController(),fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(),fenix: true);
    Get.lazyPut<HomeRecommendDetailController>(() => HomeRecommendDetailController(),fenix: true);
    Get.lazyPut<HomeConditionDetailController>(() => HomeConditionDetailController(),fenix: true);
    Get.lazyPut<FindRecommendController>(() => FindRecommendController(),fenix: true);
    Get.lazyPut<FindFocusController>(() => FindFocusController(),fenix: true);
    Get.lazyPut<FindTopicIndexController>(() => FindTopicIndexController(),fenix: true);
    Get.lazyPut<TopicIndexController>(() => TopicIndexController(),fenix: true);
    Get.lazyPut<TopicPetController>(() => TopicPetController(),fenix: true);
    Get.lazyPut<TopicPetDetailController>(() => TopicPetDetailController(),fenix: true);
  }
}
