import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/home_video_item_model.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:get/get.dart';

class HomeVideoDetailController extends GetxController {
  List<HomeVideoItemModel> videoList = HomeVideoListModel(list: []).list; //视频列表
  HomeVideoItemModel currentModel = HomeVideoItemModel(atusers:[]);
  int currentIndex = 0;
  int postPage = 1;
  bool isLoading = true; // 数据加载中
  String prompt = ''; //提示语

  @override
  void onInit() {
    super.onInit();
    requestVideoList(1);
  }

  // 获取视频列表
  Future<void> requestVideoList(int pageIndex) async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    int messageId = Get.arguments['messageId'];
    var formData = {
      'userLoginId': userInfo.userId,
      'messageId': messageId,
      'pageIndex': pageIndex,
      'orderColumn': 'create_time',
      'pageSize': 10,
    };
    HttpUtil.get(HttpOptions.selectCurrentVideoPage, params: formData,
        onSuccess: (response) {
      isLoading = false;
      prompt = '';
      if (response.rel) {
        if (response.data != null) {
          HomeVideoListModel homeVideoListModel =
              HomeVideoListModel.fromJson(response.data);
          if (homeVideoListModel.list.isNotEmpty) {
            videoList.addAll(homeVideoListModel.list);
            update();
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

  void onPageChanged(int index) {
    currentIndex = index;
    currentModel = videoList[index];
    if(index == videoList.length - 2) {
      postPage ++;
      requestVideoList(postPage);
    }
  }
}
