import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/home_condition_item_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:cute_pet/models/pet_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  late ScrollController scrollController;
  late RefreshController refreshRecommendController;
  late RefreshController refreshConditionController;
  List<PetCardItemModel> petList = PetCardListModel(list: []).list; //推荐列表
  List<HomeConditionItemModel> conditionList = HomeConditionListModel(list: []).list; //动态列表
  var isShowAppImg = false; //是否显示顶部的小头像
  int pageSizeRecommend = 1;
  int pageNumRecommend = 10;
  bool isLoadingRecommend = true; // 数据加载中
  String promptRecommend = ''; //提示语
  int pageSizeCondition = 1;
  int pageNumCondition = 10;
  bool isLoadingCondition = true; // 数据加载中
  String promptCondition = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    refreshRecommendController = RefreshController(initialRefresh: false);
    refreshConditionController = RefreshController(initialRefresh: false);
    scrollController.addListener(() {
      if (scrollController.offset > 280.h) {
        isShowAppImg = true;
      } else {
        isShowAppImg = false;
      }
      update();
    });
    getTrialReportList();
    getSelectMessageRecommendList();
  }

  // 获取推荐列表
  Future<void> getTrialReportList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'userLoginId': userInfo.userId,
      'auditStatus': 1,
      'pageIndex': pageSizeRecommend,
      'pageSize': pageNumRecommend,
    };
    HttpUtil.get(HttpOptions.getTrialReportList, params: formData,
        onSuccess: (response) {
      isLoadingRecommend = false;
      promptRecommend = '';
      if (response.rel) {
        if (response.data['records'] != null) {
          PetCardListModel petCardListModel =
              PetCardListModel.fromJson(response.data['records']);
          if (petCardListModel.list.isNotEmpty) {
            petList.addAll(petCardListModel.list);
            update();
          } else {
            refreshRecommendController.loadNoData();
          }
        }
      } else {
        promptRecommend = response.message;
      }
      update();
    }, onError: (error) {
      isLoadingRecommend = false;
      promptRecommend = error.toString();
      update();
    });
  }

  // 获取动态列表
  Future<void> getSelectMessageRecommendList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'userLoginId': userInfo.userId,
      'pageIndex': pageSizeCondition,
      'reportTotal': pageNumCondition,
    };
    HttpUtil.get(HttpOptions.selectMessageRecommendList, params: formData,
        onSuccess: (response) {
      isLoadingCondition = false;
      promptCondition = '';
      if (response.rel) {
        if (response.data['messageList'] != null) {
          HomeConditionListModel homeConditionListModel =
              HomeConditionListModel.fromJson(response.data['messageList']);
          if (homeConditionListModel.list.isNotEmpty) {
            conditionList.addAll(homeConditionListModel.list);
            update();
          } else {
            refreshConditionController.loadNoData();
          }
        }
      } else {
        promptCondition = response.message;
      }
      update();
    }, onError: (error) {
      isLoadingCondition = false;
      promptCondition = error.toString();
      update();
    });
  }

  Future<void> onRefreshCommend() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageSizeRecommend = 1;
    petList = PetCardListModel(list: []).list;
    getTrialReportList();
    refreshRecommendController.refreshCompleted();
  }

  Future<void> onLoadingCommend() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageSizeRecommend++;
    getTrialReportList();
    refreshRecommendController.loadComplete();
  }

  Future<void> onRefreshCondition() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageSizeCondition = 1;
    conditionList = HomeConditionListModel(list: []).list;
    getSelectMessageRecommendList();
    refreshConditionController.refreshCompleted();
  }

  Future<void> onLoadingCondition() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageSizeCondition++;
    getSelectMessageRecommendList();
    refreshConditionController.loadComplete();
  }
}
