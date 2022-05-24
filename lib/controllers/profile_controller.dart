import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:cute_pet/models/pet_info_model.dart';
import 'package:cute_pet/models/profile_info_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var hasToken = false;
  List<PetItemModel> petList = PetListModel(list: []).list;
  PetItemModel petInfo = PetItemModel(nearlyGrowPlanList: []);
  ProfileInfoModel profileInfo = ProfileInfoModel(
      user: User(),
      userinfo: Userinfo(),
      userlevel: Userlevel(),
      usermedalList: [],
      targetRule: TargetRule(),
      userMember: UserMember());

  @override
  void onInit() {
    super.onInit();
    // print('ProfileInfoModel---------');
    getUserToken();
  }

  // 获取最新的token信息
  getUserToken() async {
    String isToken = await SharedStorage.getToken() ?? false;
    hasToken = isToken.isNotEmpty ? true : false;
    if (hasToken) {
      getUserInfo();
      getPet();
    }
    update();
  }

  // 重新获取宠物信息
  resetPetInfo(int petID) {
    petList.clear();
    getPet();
    for (var item in petList) {
      if (item.petId == petID) {
        petInfo = item;
      }
    }
  }

  // 获取用户信息
  Future getUserInfo() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'userId': userInfo.userId,
    };
    HttpUtil.get(HttpOptions.userIndex, params: formData,
        onSuccess: (response) {
      if (response.rel) {
        ProfileInfoModel profileInfoModel =
            ProfileInfoModel.fromJson(response.data);
        profileInfo = profileInfoModel;
        update();
      }
    }, onError: (error) {
      EasyLoading.showError(error.toString());
    });
  }

  // 获取宠物信息
  getPet() async {
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    var formData = {
      'userId': userInfo.userId,
    };
    HttpUtil.get(HttpOptions.selectUserId, params: formData,
        onSuccess: (response) {
      if (response.rel) {
        PetListModel petInfoModel = PetListModel.fromJson(response.data);
        petList.addAll(petInfoModel.list);
        if (petList.isNotEmpty) {
          petInfo = petList[0];
        }
        update();
      }
    }, onError: (error) {
      EasyLoading.showError(error.toString());
    });
  }

  // 切换宠物
  switchPet(PetItemModel petItemModel) {
    petInfo = petItemModel;
    update();
  }
}
