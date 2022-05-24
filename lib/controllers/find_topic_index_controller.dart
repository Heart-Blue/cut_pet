import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/controllers/topic_pet_detail_controller.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/find_topic_content_model.dart';
import 'package:cute_pet/models/find_topic_top_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindTopicIndexController extends GetxController {
  List<FindTopicTopItemModel> findTopImgList =
      FindTopicTopListModel(list: []).list;
  List<FindTopicContentItemModel> contentList =
      FindTopicContentListModel(list: []).list;
  late RefreshController refreshController;
  int pageIndex = 1;
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语
  final _topicPetDetailController = Get.find<TopicPetDetailController>();

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    fetchTopics();
    fetchQuestions();
  }

  /// 发现-热门话题
  fetchTopics() {
    var formData = {
      'dogBreedId': 102,
    };
    HttpUtil.get(HttpOptions.getHotTribe, params: formData,
        onSuccess: (response) {
      if (response.rel && response.data['records'] != null) {
        FindTopicTopListModel findTopicTopListModel =
            FindTopicTopListModel.fromJson(response.data['records']);
        if (findTopicTopListModel.list.isNotEmpty) {
          findTopImgList.addAll(findTopicTopListModel.list);
          update();
        }
      }
    }, onError: (error) {});
  }

  /// 发现-热门讨论
  fetchQuestions() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'pageIndex': pageIndex,
      'pageSize': 10,
      'userId': userInfo.userId,
    };
    isLoading = true;
    HttpUtil.get(HttpOptions.selectQuestionHotList, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel && response.data['records'] != null) {
        FindTopicContentListModel findTopicContentListModel =
            FindTopicContentListModel.fromJson(response.data['records']);
        if (findTopicContentListModel.list.isNotEmpty) {
          contentList.addAll(findTopicContentListModel.list);
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

  /// 发现--点赞/取消点赞
  Future<void> requestAgree(bool agree, {int answerId = 0}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    int agreeStatus = agree ? 0 : 1;
    var formData = {
      'agreeStatus': agreeStatus,
      'answerId': answerId,
      'userId': userInfo.userId,
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.get(HttpOptions.updateAgree, params: formData,
        onSuccess: (response) {
      EasyLoading.dismiss();
      if (response.rel) {
        onRefresh();
        _topicPetDetailController.onRefresh();
        EasyLoading.showSuccess(response.message);
      } else {
        EasyLoading.showSuccess(response.message);
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(error.toString());
    });
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex = 1;
    contentList = FindTopicContentListModel(list: []).list;
    fetchQuestions();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex++;
    fetchQuestions();
    refreshController.loadComplete();
  }
}
