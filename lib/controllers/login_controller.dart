import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/controllers/find_focus_controller.dart';
import 'package:cute_pet/controllers/find_recommend_controller.dart';
import 'package:cute_pet/controllers/find_topic_index_controller.dart';
import 'package:cute_pet/controllers/home_controller.dart';
import 'package:cute_pet/controllers/profile_controller.dart';
import 'package:cute_pet/controllers/topic_root_controller.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final accountNode = FocusNode();
  final passwordNode = FocusNode();
  final account = ''.obs; //用户名
  final password = ''.obs; //密码
  bool isRememberPwd = false; //是否显示密码

  @override
  Future<void> onInit() async {
    super.onInit();
    Map loginInfo = await SharedStorage.getLoginInfo();
    accountController.text = loginInfo['username'];
    passwordController.text = loginInfo['password'];
    account.value = accountController.text;
    password.value = passwordController.text;
  }

  @override
  void onClose() {
    super.onClose();
    accountController.dispose();
    passwordController.dispose();
  }

  // 控制器，用户名，密码重置
  void loginReset() {
    accountController.clear();
    passwordController.clear();
    account.value = '';
    password.value = '';
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  Future<bool> popBack() async {
    loginReset();
    return true;
  }

  void handleRememberPwd() {
    isRememberPwd = !isRememberPwd;
    update(['rememberPwd']);
  }

  void loginAction() {
    accountNode.unfocus();
    passwordNode.unfocus();
    if (accountController.text != '123') {
      EasyLoading.showInfo('account'.tr + ': 123');

      return;
    }
    if (passwordController.text != '123') {
      EasyLoading.showInfo('password'.tr + ': 123');
      return;
    }
    Map<String, dynamic> formData = {};
    formData['username'] = '13456789417';
    formData['password'] = 'mmmm0000';
    formData['type'] = 'password';
    EasyLoading.show(status: 'loading...');
    HttpUtil.post(HttpOptions.applogin, params: formData,
        onSuccess: (response) {
      EasyLoading.dismiss();
      if (response.rel) {
        LoginProfileInfoModel loginInfo =
            LoginProfileInfoModel.fromJson(response.data);
        // 缓存用户信息
        SharedStorage.saveUserInfo(
            userId: loginInfo.userId,
            userPhone: loginInfo.userPhone,
            nickname: loginInfo.nickname,
            headImg: loginInfo.headImg);
        // 缓存token
        SharedStorage.saveToken(loginInfo.token);
        if (isRememberPwd) {
          // 缓存登录的用户名和密码
          SharedStorage.saveLoginInfo(
              account: account.value, password: password.value);
        } else {
          SharedStorage.cleanLoginInfo();
        }
        // 重新获取APP的页面信息
        getAppInfo();
        loginReset();
        Get.back();
      }
    }, onError: (e) {
      EasyLoading.showError(e.toString());
      EasyLoading.dismiss();
    });
  }
  
  // 重新获取APP的页面信息
  getAppInfo() {
    Get.find<HomeController>().onRefreshCommend();
    Get.find<HomeController>().onRefreshCondition();
    Get.find<ProfileController>().getUserToken();
    Get.find<TopicRootController>().onRefresh();
    Get.find<FindFocusController>().onRefresh();
    Get.find<FindRecommendController>().onRefresh();
    Get.find<FindTopicIndexController>().onRefresh();
  }
}
