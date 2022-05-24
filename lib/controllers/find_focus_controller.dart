import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/find_focus_content_model.dart';
import 'package:cute_pet/models/find_focus_top_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindFocusController extends GetxController {
  List<FindFocusTopItemModel> findTopImgList =
      FindFocusTopIListModel(list: []).list;
  List<FindFocusContentItemModel> contentList =
      FindFocusContentListModel(list: []).list;
  late RefreshController refreshController;
  int pageIndex = 1;
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    requestRecomFocus();
    requestFocusPostList();
  }

  /// 发现, 关注--头部头像列表
  requestRecomFocus() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    var formData = {
      'pageIndex': 1,
      'pageSize': 10,
      'userLoginId': userInfo.userId,
    };
    HttpUtil.get(HttpOptions.selectNotRelation, params: formData,
        onSuccess: (response) {
      if (response.rel && response.data['records'] != null) {
        FindFocusTopIListModel findFocusTopIListModel =
            FindFocusTopIListModel.fromJson(response.data['records']);
        if (findFocusTopIListModel.list.isNotEmpty) {
          findTopImgList.addAll(findFocusTopIListModel.list);
          update();
        }
      }
    }, onError: (error) {});
  }

  /// 发现-关注--内容列表
  requestFocusPostList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    var formData = {
      'listType': 2,
      'pageIndex': pageIndex,
      'pageSize': 10,
      'total': 388,
      'userLoginId': userInfo.userId,
    };
    isLoading = true;
    HttpUtil.get(HttpOptions.user_selectNotRelation, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel) {
        if (response.data['records'] != null) {
          FindFocusContentListModel findFocusContentListModel =
              FindFocusContentListModel.fromJson(response.data['records']);
          if (findFocusContentListModel.list.isNotEmpty) {
            contentList.addAll(findFocusContentListModel.list);
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

  /// 发现--关注/取消关注
  Future<void> requestFocus(
      {required bool attation,
      required int userByid,
      bool isContent = false}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    int isFlag = attation ? 0 : 1;
    var formData = {
      'isFlag': isFlag,
      'userByid': userByid,
      'userId': userInfo.userId,
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.get(HttpOptions.updateAttation, params: formData,
        onSuccess: (response) {
      EasyLoading.dismiss();
      if (response.rel) {
        if (isContent) {
          onRefresh();
        } else {
          for (var element in findTopImgList) {
            if (element.userId == userByid) {
              element.isRelation = !attation;
              update();
            }
          }
        }

        EasyLoading.showSuccess(attation ? 'unfollowing_succeeded'.tr : 'focus_on_success'.tr);
      } else {
        EasyLoading.showSuccess(response.message);
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(error.toString());
    });
  }

  /// 发现--点赞/取消点赞
  Future<void> requestAgree(bool agree,
      {int commentId = 0, int messageId = 0}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    int agreeStatus = agree ? 0 : 1;
    var formData = {
      'messageId': messageId,
      'agreeStatus': agreeStatus,
      'commentId': commentId,
      'userId': userInfo.userId,
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.get(HttpOptions.updateAgree, params: formData,
        onSuccess: (response) {
      EasyLoading.dismiss();
      if (response.rel) {
        onRefresh();
        EasyLoading.showSuccess(response.message);
      } else {
        EasyLoading.showSuccess(response.message);
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(error.toString());
    });
  }

  // 换一换
  refreshData() {
    findTopImgList = FindFocusTopIListModel(list: []).list;
    requestRecomFocus();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex = 1;
    contentList = FindFocusContentListModel(list: []).list;
    requestFocusPostList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageIndex++;
    requestFocusPostList();
    refreshController.loadComplete();
  }
}
