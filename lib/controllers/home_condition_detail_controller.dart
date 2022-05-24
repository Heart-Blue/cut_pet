import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/comment_model.dart';
import 'package:cute_pet/models/home_condition_detail_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeConditionDetailController extends GetxController {
  HomeConditionDetailModel homeConditionDetailModel = HomeConditionDetailModel(
      files: <Files>[], atusers: [], agrees: <Agrees>[]);
  List<CommentItemModel> commentList = CommentListModel(list: []).list;
  late RefreshController refreshController;
  int pageIndex = 1;

  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语
  late FocusNode focusNode;
  late TextEditingController editController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    focusNode = FocusNode();
    editController = TextEditingController();
    loadConditionDetail();
    requestCommentList();
  }

  // 获取文章详情
  loadConditionDetail() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    final result = Get.arguments;
    var formData = {
      'userId': userInfo.userId,
      'messageId': result['messageId'],
    };
    HttpUtil.get(HttpOptions.find_detail, params: formData,
        onSuccess: (response) {
      if (response.rel && response.data != null) {
        homeConditionDetailModel =
            HomeConditionDetailModel.fromJson(response.data);
        update();
      }
    }, onError: (error) {});
  }

  // 获取评论列表
  requestCommentList() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    final result = Get.arguments;
    var formData = {
      'userId': userInfo.userId,
      'userLoginId': userInfo.userId,
      'messageId': result['messageId'],
      'pageIndex': pageIndex,
      'pageSize': 10,
      'replySize': 5,
    };
    isLoading = true;
    HttpUtil.get(HttpOptions.selectCommentPage, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel && response.data['records'] != null) {
        CommentListModel commentListModel =
            CommentListModel.fromJson(response.data['records']);
        if (commentListModel.list.isNotEmpty) {
          commentList.addAll(commentListModel.list);
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

  /// 发现-评论
  Future<void> requestComment({required String commentInfo}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    // 获取参数
    final result = Get.arguments;
    var formData = {
      'messageId': result['messageId'],
      'commentInfo': commentInfo,
      'userId': userInfo.userId,
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.post(HttpOptions.comment_save, params: formData,
        onSuccess: (response) {
      EasyLoading.dismiss();
      if (response.rel) {
        onRefresh();
        EasyLoading.showSuccess('评论成功');
      } else {
        EasyLoading.showSuccess('评论失败');
      }
      update();
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(error.toString());
      update();
    });
  }

  /// 发现--点赞/取消点赞
  Future<void> requestAgree(bool agree, {int commentId = 0}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    final result = Get.arguments;
    int agreeStatus = agree ? 0 : 1;
    var formData = {
      'messageId': commentId == 0 ? result['messageId'] : 'null',
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

  /// 发现--收藏/取消收藏
  Future<void> requestCollection(bool collection, {int commentId = 0}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    final result = Get.arguments;
    int state = collection ? 1 : 0;
    var formData = {
      'messageId': result['messageId'],
      'collectionsStatus': state,
      'commentId': commentId,
      'userId': userInfo.userId,
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.post(HttpOptions.user_collection, params: formData,
        onSuccess: (response) {
      EasyLoading.dismiss();
      if (response.rel) {
        loadConditionDetail();
        EasyLoading.showSuccess(response.message);
      } else {
        EasyLoading.showSuccess(response.message);
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(error.toString());
    });
  }

  /// 发现--关注/取消关注
  Future<void> requestFocus(
      {required bool attation, required int userByid}) async {
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
        loadConditionDetail();
        EasyLoading.showSuccess(attation ? 'unfollowing_succeeded'.tr : 'focus_on_success'.tr);
      } else {
        EasyLoading.showSuccess(response.message);
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(error.toString());
    });
  }

  /// 发现-回复评论
  Future<void> replyComment(
      {required String commentInfo,
      required int commentId,
      required int beReplyedUserId}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'beReplyedUserId': beReplyedUserId,
      'commentInfo': commentInfo,
      'commentId': commentId,
      'replyUserId': userInfo.userId,
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.post(HttpOptions.comment_reply_save, params: formData,
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

  /// 发现-删除评论
  Future<void> deleteComment({required int commentId}) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'commentId': commentId,
      'userLoginId': userInfo.userId,
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.get(HttpOptions.comment_delete, params: formData,
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

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    homeConditionDetailModel = HomeConditionDetailModel(
        files: <Files>[], atusers: [], agrees: <Agrees>[]);
    commentList = CommentListModel(list: []).list;
    pageIndex = 1;
    loadConditionDetail();
    requestCommentList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    homeConditionDetailModel = HomeConditionDetailModel(
        files: <Files>[], atusers: [], agrees: <Agrees>[]);
    pageIndex++;
    loadConditionDetail();
    requestCommentList();
    refreshController.loadComplete();
  }
}
