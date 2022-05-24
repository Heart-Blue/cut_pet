import 'package:cute_pet/caches/shared_storage.dart';
import 'package:cute_pet/components/drop_down_select_box.dart';
import 'package:cute_pet/components/form_common_widget.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/config/http_options.dart';
import 'package:cute_pet/controllers/profile_controller.dart';
import 'package:cute_pet/http/http_util.dart';
import 'package:cute_pet/models/login_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeEditPet extends StatefulWidget {
  const HomeEditPet({Key? key}) : super(key: key);

  @override
  State<HomeEditPet> createState() => _HomeEditPetState();
}

class _HomeEditPetState extends State<HomeEditPet> {
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  TextEditingController petTypeController = TextEditingController();
  FocusNode petTypeFocus = FocusNode();
  TextEditingController petWeightController = TextEditingController();
  FocusNode petWeightFocus = FocusNode();
  String sex = '';
  String birthday = '';
  String adoptDay = '';
  String sterilizate = '';
  final _profileController = Get.find<ProfileController>();

  // 提交前的校验
  check() {
    if (nameController.text.isEmpty) {
      EasyLoading.showInfo('please_enter_a_nickname'.tr);
      return false;
    }
    if (sex.isEmpty) {
      EasyLoading.showInfo('please_select_gender'.tr);
      return false;
    }
    if (petTypeController.text.isEmpty) {
      EasyLoading.showInfo('please_enter_pet_breed'.tr);
      return false;
    }
    if (birthday.isEmpty) {
      EasyLoading.showInfo('please_select_your_date_of_birth'.tr);
      return false;
    }
    if (adoptDay.isEmpty) {
      EasyLoading.showInfo('please_select_the_adoption_date'.tr);
      return false;
    }
    if (sterilizate.isEmpty) {
      EasyLoading.showInfo('please_select_sterilization_status'.tr);
      return false;
    }
    if (petWeightController.text.isEmpty) {
      EasyLoading.showInfo('please_enter_your_pets_weight'.tr);
      return false;
    }
    return true;
  }

  submit() async {
    if (!check()) return;
    LoginProfileInfoModel userInfo = await SharedStorage.getUserInfo();
    Map<String, dynamic> formData = {
      "petImg": _profileController.petInfo.petImg,
      "petId":_profileController.petInfo.petId,
      "adoptionDate": adoptDay,
      "userId": userInfo.userId,
      "petKg": petWeightController.text,
      "petName": nameController.text,
      "isSterilization": sterilizate == 'neutered'.tr ? '1' : '0',
      "birthday": birthday,
      "sex": sex == 'GG' ? '0' : '1',
      "petBreed": petTypeController.text
    };
    EasyLoading.show(status: 'loading...');
    HttpUtil.post(HttpOptions.petSave, data: formData,
        onSuccess: (response) {
      EasyLoading.dismiss();
      if (response.rel) {
        EasyLoading.showSuccess('modify_successfully'.tr);
        _profileController.resetPetInfo(_profileController.petInfo.petId);
        Future.delayed(const Duration(milliseconds: 1000),() {
          Get.back();
        });
      }
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showError(error.toString());
    });
  }

  initInfo() {
    if (_profileController.petInfo.age.isNotEmpty) {
      nameController.text = _profileController.petInfo.petName;
      sex =  _profileController.petInfo.sex == '0' ? 'GG' : 'MM';
      petTypeController.text =  _profileController.petInfo.petBreed;
      birthday =  _profileController.petInfo.birthday;
      adoptDay =  _profileController.petInfo.adoptionDate;
      sterilizate =
           _profileController.petInfo.isSterilization == '0' ? 'neutered'.tr : 'unneutered'.tr;
      petWeightController.text =  _profileController.petInfo.petKg;
    }
  }

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('edit_pet'.tr),
      ),
      body: Container(
        color: AppColors.unactive.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300.h,
                alignment: Alignment.center,
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.w),
                  child: GetBuilder(
                    init: _profileController,
                    builder: (_) {
                      return NetLoadImage(
                        imageUrl: _profileController.petInfo.petImg,
                        width: 150.w,
                        height: 150.w,
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                child:  Text('mandatory'.tr),
              ),
              basicInfo(),
              submitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget basicInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormCommonWidget(
            title: "nickname".tr,
            hintText: "please_enter_a_nickname".tr,
            controller: nameController,
            focus: nameFocus,
            readOnly: false,
          ),
          infoLineWidget(),
          DropDownSelectBox(
            title: 'sex'.tr,
            viewInfo: sex,
            isShowView: false,
            dataList: const ['GG', 'MM'],
            selectIcon: SelectTypeIcon.cascade,
            defaultInfo: "please_select_gender".tr,
            onTapData: (val) {
              setState(() {
                sex = val;
              });
            },
          ),
          infoLineWidget(),
          FormCommonWidget(
            title: "varieties_of_pet".tr,
            hintText: "please_enter_pet_breed".tr,
            controller: petTypeController,
            focus: petTypeFocus,
            readOnly: false,
          ),
          infoLineWidget(),
          DropDownSelectBox(
            title: 'date_of_birth'.tr,
            viewInfo: birthday,
            isShowView: false,
            selectIcon: SelectTypeIcon.calendar,
            defaultInfo: "please_select_your_date_of_birth".tr,
            onTapData: (val) {
              setState(() {
                birthday = val;
              });
            },
          ),
          infoLineWidget(),
          DropDownSelectBox(
            title: 'adopt_of_birth'.tr,
            viewInfo: adoptDay,
            isShowView: false,
            selectIcon: SelectTypeIcon.calendar,
            defaultInfo: "please_select_the_adoption_date".tr,
            onTapData: (val) {
              setState(() {
                adoptDay = val;
              });
            },
          ),
          infoLineWidget(),
          DropDownSelectBox(
            title: 'sterilization_state'.tr,
            viewInfo: sterilizate,
            isShowView: false,
            dataList:  ['neutered'.tr, 'unneutered'.tr],
            selectIcon: SelectTypeIcon.cascade,
            defaultInfo: "please_select_sterilization_status".tr,
            onTapData: (val) {
              setState(() {
                sterilizate = val;
              });
            },
          ),
          infoLineWidget(),
          FormCommonWidget(
            title: "pet_weight".tr,
            hintText: "please_enter_your_pets_weight".tr,
            controller: petWeightController,
            focus: petWeightFocus,
            readOnly: false,
          ),
        ],
      ),
    );
  }

  Widget infoLineWidget() {
    return const Divider(
      color: AppColors.unactive,
      height: 1,
    );
  }

  Widget submitButton() {
    return Container(
      width: Get.width,
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      margin: EdgeInsets.only(top: 30.h),
      child: ElevatedButton(
        child: Text('save'.tr,
            style: TextStyle(fontSize: 32.sp, color: Colors.black)),
        onPressed: () {
          submit();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.w),
          ),
        ),
      ),
    );
  }
}
