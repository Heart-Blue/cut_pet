import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/find_topic_content_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicRootController extends GetxController {
  List<FindTopicContentItemModel> contentList =
      FindTopicContentListModel(list: []).list;
  late RefreshController refreshController;
  int pageIndex = 1;
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    fetchQuestions();
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
