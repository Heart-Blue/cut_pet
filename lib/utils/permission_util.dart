import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

enum TKPermission {
  camera,
  photos,
  microphone,
  storage,
}

class TKPermissionUtil {
  /// 请求权限, 仅支持: 相机, 相册, 麦克风, 存储
  static Future<bool> perssionRequest(
      TKPermission type) async {
    String typeName = '';
    Permission permissionType = Permission.unknown;
    switch (type) {
      case TKPermission.camera:
        typeName = '相机';
        permissionType = Permission.camera;
        break;
      case TKPermission.photos:
        typeName = '相册';
        permissionType = Permission.photos;
        break;
      case TKPermission.microphone:
        typeName = '麦克风';
        permissionType = Permission.microphone;
        break;
      case TKPermission.storage:
        typeName = '存储';
        permissionType = Permission.storage;
        break;
      default:
    }

    var status = await permissionType.status;
    if (status == PermissionStatus.restricted) {
      Map<Permission, PermissionStatus> statuses =
          await [permissionType].request();
      var state = statuses[type];

      if (state == PermissionStatus.granted) {
        return true;
      } else if (state == PermissionStatus.denied ||
          state == PermissionStatus.restricted) {
        EasyLoading.show(status: '您已拒绝$typeName访问权限');
        return false;
      }
      return false;
    } else if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted) {
      Get.defaultDialog(
          title: "温馨提示",
          titlePadding: EdgeInsets.only(top: 10.h),
          middleText: "请前往设置->麻花宠物中开启权限",
          cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.unactive)),
              child: const Text('取消')),
          confirm: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.active)),
              onPressed: () {
                Get.back();
                openAppSettings();
              },
              child: const Text('确认')),
          barrierDismissible: true,
          radius: 10);
      return false;
    } else if (status == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  /// 请求定位权限
  static Future<bool> locationPermission() async {
    var status = await Permission.locationWhenInUse.isGranted;
    if (status) {
      return true;
    } else {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.locationWhenInUse].request();
      var state = statuses[Permission.locationWhenInUse];
      if (state == PermissionStatus.granted) {
        return true;
      } else if (state == PermissionStatus.denied ||
          state == PermissionStatus.restricted) {
        EasyLoading.show(status: '您已拒绝位置访问权限');
        return false;
      }
      return false;
    }
  }
}
