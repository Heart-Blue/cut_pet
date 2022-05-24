import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/home_recommend_detail_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomeRecommendDetailController extends GetxController {
  HomeRecommendDetailModel homeRecommendDetailModel =
      HomeRecommendDetailModel(fileList: []); // 详情数据
  final _homeController = Get.find<HomeController>();
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    loadGrassDetail();
  }

  // 获取推荐详情
  loadGrassDetail() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    final result = Get.arguments;
    var formData = {
      'loginUserId': userInfo.userId,
      'trialReportId': result['trialReportId'],
    };
    HttpUtil.post(HttpOptions.getTrialReportInfo, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel) {
        if (response.data != null) {
          homeRecommendDetailModel =
              HomeRecommendDetailModel.fromJson(response.data);
          update();
        }
      } else {
        prompt = response.message;
      }
      update();
    }, onError: (error) {
      isLoading = false;
      prompt = error.toString();
      update();
    });
  }

  // 点赞
  loadAgree(int agreeStatus) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    final result = Get.arguments;
    var formData = {
      'userId': userInfo.userId,
      'trialReportId': result['trialReportId'],
      'agreeStatus': agreeStatus,
    };
    HttpUtil.post(HttpOptions.updateTrialReportAgree, params: formData,
        onSuccess: (response) {
      if (response.rel) {
        EasyLoading.showSuccess(agreeStatus == 1 ? 'unliked_succeeded'.tr : 'thumb_up_success'.tr);
        loadGrassDetail();
        _homeController.onRefreshCommend();
      }
    }, onError: (error) {
      EasyLoading.showError(error.toString());
    });
  }

  // 收藏
  loadCollection(int collectionsStatus) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    final result = Get.arguments;
    var formData = {
      'userId': userInfo.userId,
      'trialReportId': result['trialReportId'],
      'collectionsStatus': collectionsStatus,
    };
    HttpUtil.post(HttpOptions.collectionApi, params: formData,
        onSuccess: (response) {
      if (response.rel) {
        EasyLoading.showSuccess(collectionsStatus == 1 ? 'unfavorites_successful'.tr : 'collection_of_success'.tr);
        loadGrassDetail();
        _homeController.onRefreshCommend();
      }
    }, onError: (error) {
      EasyLoading.showError(error.toString());
    });
  }
}
