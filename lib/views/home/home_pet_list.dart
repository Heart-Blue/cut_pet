import 'package:cached_network_image/cached_network_image.dart';
import 'package:cute_pet/components/network_image.dart';
import 'package:cute_pet/controllers/profile_controller.dart';
import 'package:cute_pet/models/pet_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePetList extends StatelessWidget {
  HomePetList({Key? key}) : super(key: key);
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('pet_list'.tr),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView.builder(
            itemCount: _profileController.petList.length, itemBuilder: (context, index) => itemCard(_profileController.petList[index])),
      ),
    );
  }

  Widget itemCard(PetItemModel petItemModel) {
    return GestureDetector(
      onTap: () {
        _profileController.switchPet(petItemModel);
        EasyLoading.showSuccess('switch_success'.tr);
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.back();
        });
      },
      child: Container(
        height: 280.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 30.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    petItemModel.backgroundUrl),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              top: 50.h,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w)),
                width: Get.width - 150.w,
                height: 180.h,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder(
                      init: _profileController,
                      builder: (_) {
                        return Text(
                          petItemModel.petName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 30.sp, color: Colors.black),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GetBuilder(
                      init: _profileController,
                      builder: (_) {
                        return Text(
                          '${petItemModel.petBreed}|${petItemModel.age}|${petItemModel.petKg}KG',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.black.withOpacity(0.5)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 20.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75.w),
                  child: GetBuilder(
                    init: _profileController,
                    builder: (_) {
                      return NetLoadImage(
                        imageUrl:
                            petItemModel.petImg,
                        width: 75.w,
                        height: 75.w,
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
