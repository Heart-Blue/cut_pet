// ignore_for_file: unused_local_variable

import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:cute_pet/models/topic_pet_model.dart';
import 'package:get/get.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicPetController extends GetxController {
  List<TopicPetItemModel> petList = TopicPetListModel(list: []).list;
  late RefreshController refreshController;
  int pageIndex = 1;
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    loadPetList();
  }

  // 发现-热门话题
  loadPetList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'pageIndex': pageIndex,
      'pageSize': 10,
      'userId': userInfo.userId,
    };
    isLoading = true;
    HttpUtil.post(HttpOptions.allTribeList, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel && response.data['records'] != null) {
        TopicPetListModel topicPetListModel =
            TopicPetListModel.fromJson(response.data['records']);
        if (topicPetListModel.list.isNotEmpty) {
          petList.addAll(topicPetListModel.list);
        } else {
          refreshController.loadNoData();
        }
        update();
      } else {
        refreshController.loadNoData();
        prompt = response.message;
      }
      update();
    }, onError: (error) {
      isLoading = false;
      prompt = error.toString();
      update();
    });
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex = 1;
    petList = TopicPetListModel(list: []).list;
    update();
    loadPetList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex++;
    loadPetList();
    refreshController.loadComplete();
  }
}
