import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/find_topic_content_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:cute_pet/models/topic_per_info_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicPetDetailController extends GetxController {
  List<FindTopicContentItemModel> discussList =
      FindTopicContentListModel(list: []).list;
  TopicPetInfoModel petInfo = TopicPetInfoModel();
  late RefreshController refreshController;
  int pageIndex = 1;
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语
  int orderType = 1; //1--热门 2--全部问题

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    loadQuestionList();
    loadTribeInfo();
  }

  // 发现-犬种信息
  loadTribeInfo() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var result = Get.arguments;
    var formData = {
      'tribeId': result['tribeId'],
      'loginUserId': userInfo.userId,
    };
    HttpUtil.post(HttpOptions.selectTribeInfo, params: formData,
        onSuccess: (response) {
      prompt = '';
      if (response.rel && response.data != null) {
        petInfo = TopicPetInfoModel.fromJson(response.data);
        update();
      }
    }, onError: (error) {
    });
  }

  // 发现-讨论列表
  loadQuestionList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var result = Get.arguments;
    var formData = {
      'pageIndex': pageIndex,
      'pageSize': 10,
      'orderType': orderType,
      'tribeId': result['tribeId'],
      'userId': userInfo.userId,
    };
    isLoading = true;
    HttpUtil.get(HttpOptions.selectQuestionList, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel && response.data['records'] != null) {
        FindTopicContentListModel findTopicContentListModel =
            FindTopicContentListModel.fromJson(response.data['records']);
        if (findTopicContentListModel.list.isNotEmpty) {
          discussList.addAll(findTopicContentListModel.list);
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
    discussList = FindTopicContentListModel(list: []).list;
    loadQuestionList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex++;
    loadQuestionList();
    refreshController.loadComplete();
  }
}
