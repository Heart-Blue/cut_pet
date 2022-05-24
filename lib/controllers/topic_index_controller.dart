import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:cute_pet/models/topic_hot_model.dart';
import 'package:cute_pet/models/topic_latest_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicIndexController extends GetxController {
  List<TopicHotItemModel> hotList = TopicHotListModel(list: []).list;
  List<TopicLatestItemModel> latestList = TopicLatestListModel(list: []).list;
  late RefreshController refreshControllerHot;
  late RefreshController refreshControllerLatest;
  late ScrollController scrollController;
  int pageIndexHot = 1;
  int pageIndexLatest = 1;
  bool isLoadingHot = true; // 数据加载中
  String promptHot = ''; //提示语
  bool isLoadingLatest = true; // 数据加载中
  String promptLatest = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    refreshControllerHot = RefreshController(initialRefresh: false);
    refreshControllerLatest = RefreshController(initialRefresh: false);
    scrollController = ScrollController();
    loadHotList();
    loadLatestList();
  }

  /// 话题-热门
  loadHotList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var reslut = Get.arguments;
    var formData = {
      'questionId': reslut['questionId'],
      'pageIndex': pageIndexHot,
      'pageSize': 10,
      'userId': userInfo.userId,
    };
    isLoadingHot = true;
    HttpUtil.get(HttpOptions.selectHotAnswerPage, params: formData,
        onSuccess: (response) {
      isLoadingHot = false;
      promptHot = '';
      if (response.rel && response.data['records'] != null) {
        TopicHotListModel topicHotListModel =
            TopicHotListModel.fromJson(response.data['records']);
        if (topicHotListModel.list.isNotEmpty) {
          hotList.addAll(topicHotListModel.list);
        } else {
          refreshControllerHot.loadNoData();
        }
        update();
      } else {
        refreshControllerHot.loadNoData();
        promptHot = response.message;
      }
      update();
    }, onError: (error) {
      isLoadingHot = false;
      promptHot = error.toString();
      update();
    });
  }

  /// 话题-最新
  loadLatestList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var reslut = Get.arguments;
    var formData = {
      'questionId': reslut['questionId'],
      'pageIndex': pageIndexLatest,
      'pageSize': 10,
      'userId': userInfo.userId,
    };
    isLoadingLatest = true;
    HttpUtil.get(HttpOptions.selectNewAnswerPage, params: formData,
        onSuccess: (response) {
      isLoadingLatest = false;
      promptLatest = '';
      if (response.rel && response.data['records'] != null) {
        TopicLatestListModel topicLatestListModel =
            TopicLatestListModel.fromJson(response.data['records']);
        if (topicLatestListModel.list.isNotEmpty) {
          latestList.addAll(topicLatestListModel.list);
        } else {
          refreshControllerLatest.loadNoData();
        }
        update();
      } else {
        refreshControllerLatest.loadNoData();
        promptLatest = response.message;
      }
      update();
    }, onError: (error) {
      isLoadingLatest = false;
      promptLatest = error.toString();
      update();
    });
  }

  Future<void> onRefreshHot() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndexHot = 1;
    hotList = TopicHotListModel(list: []).list;
    update();
    loadHotList();
    refreshControllerHot.refreshCompleted();
  }

  Future<void> onLoadingHot() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndexHot++;
    loadHotList();
    refreshControllerHot.loadComplete();
  }

  Future<void> onRefreshLatest() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndexLatest = 1;
    latestList = TopicLatestListModel(list: []).list;
    update();
    loadLatestList();
    refreshControllerLatest.refreshCompleted();
  }

  Future<void> onLoadingLatest() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndexLatest++;
    loadLatestList();
    refreshControllerLatest.loadComplete();
  }
}
