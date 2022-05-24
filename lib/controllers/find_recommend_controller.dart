import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/find_recommend_image_model.dart';
import 'package:cute_pet/models/home_condition_item_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindRecommendController extends GetxController {
  List<FindRecommendImageItemModel> findRecommendImageList =
      FindRecommendImageListModel(list: []).list;
  List<HomeConditionItemModel> conditionList =
      HomeConditionListModel(list: []).list; //动态列表
  late RefreshController refreshController;
  int pageIndex = 1;
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    requestCommentList();
    requestRecommendList();
  }

  /// 发现, 推荐---轮播图
  requestCommentList() async {
    // 获取参数
    var formData = {
      'pageIndex': 1,
      'pageSize': 10,
    };
    HttpUtil.get(HttpOptions.selectMessageLabelList, params: formData,
        onSuccess: (response) {
      if (response.rel && response.data['records'] != null) {
        FindRecommendImageListModel findRecommendImageListModel =
            FindRecommendImageListModel.fromJson(response.data['records']);
        if (findRecommendImageListModel.list.isNotEmpty) {
          findRecommendImageList.addAll(findRecommendImageListModel.list);
          update();
        }
      }
    }, onError: (error) {});
  }

  /// 发现-推荐: 瀑布流列表
  requestRecommendList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    var formData = {
      'messageTotal': 8871,
      'pageIndex': pageIndex,
      'reportTotal': 26,
      'userLoginId': userInfo.userId,
    };
    isLoading = true;
    HttpUtil.get(HttpOptions.selectMessageRecommendList, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel) {
        if (response.data['messageList'] != null) {
          HomeConditionListModel homeConditionListModel =
              HomeConditionListModel.fromJson(response.data['messageList']);
          if (homeConditionListModel.list.isNotEmpty) {
            conditionList.addAll(homeConditionListModel.list);
            update();
          } else {
            refreshController.loadNoData();
          }
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

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex = 1;
    conditionList = HomeConditionListModel(list: []).list;
    requestRecommendList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex++;
    requestRecommendList();
    refreshController.loadComplete();
  }
}
