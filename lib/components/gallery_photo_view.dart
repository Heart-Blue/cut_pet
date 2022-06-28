import 'dart:io';
import 'dart:typed_data';
import 'package:cute_pet/utils/find_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view_gallery.dart';

/*
 *@Author: zhengjing
 *@Date: 2021-08-04 10:38:09
 *@Description: 图片预览公共组件
 */

class PhotoViewGalleryScreen extends StatefulWidget {
  final List? images;
  final int index;
  final ImageType type;

  ///图片类型

  const PhotoViewGalleryScreen(
      {Key? key,
      @required this.images,
      this.index = 0,
      this.type = ImageType.net})
      : super(key: key);

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int currentIndex = 0;
  late PageController controller;
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black,
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  dynamic tmpImage;
                  if (widget.type == ImageType.net) {
                    tmpImage = NetworkImage(widget.images![index]);
                  } else if (widget.type == ImageType.asset) {
                    tmpImage = AssetImage(widget.images![index]);
                  } else if (widget.type == ImageType.file) {
                    tmpImage = FileImage(File(widget.images![index].path));
                  } else {
                    tmpImage = NetworkImage(widget.images![index]);
                  }
                  return PhotoViewGalleryPageOptions(
                    imageProvider: tmpImage,
                  );
                },
                itemCount: widget.images!.length,
                backgroundDecoration: null,
                pageController: controller,
                enableRotation: false,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            Positioned(
              //图片index显示
              top: MediaQuery.of(context).padding.top + 15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("${currentIndex + 1}/${widget.images!.length}",
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            Positioned(
              //右上角关闭按钮
              right: 10,
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            // 保存图片部件
            Positioned(
                bottom: MediaQuery.of(context).padding.bottom + 16,
                right: 10,
                child: Visibility(
                  visible: widget.type == ImageType.net,
                  child: TextButton(
                    child: const Text(
                      '保存图片',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () async {
                      bool permission = await requestPermission();
                      permission
                          ? saveNetworkImg(widget.images![currentIndex])
                          : null;
                    },
                  ),
                ))
          ],
        )));
  }

  // 动态申请权限，ios 要在info.plist 上面添加
  Future<bool> requestPermission() async {
    late PermissionStatus status;
    if (Platform.isIOS) {
      status = await Permission.photosAddOnly.request();
    } else {
      status = await Permission.storage.request();
    }
    if (status != PermissionStatus.granted) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('You need to grant album permissions'),
              content: const Text(
                  'Please go to your mobile phone to set the permission to open the corresponding album'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('cancle'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('confirm'),
                  onPressed: () {
                    Get.back();
                    openAppSettings();
                  },
                ),
              ],
            );
          });
    } else {
      return true;
    }
    return false;
  }

  // 保存网络图片
  saveNetworkImg(String imgUrl) async {
    var response = await Dio()
        .get(imgUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
    );
    if (result['isSuccess']) {
      EasyLoading.showSuccess("保存成功，请前往 '相册' 查看");
    } else {
      EasyLoading.showError('保存失败');
    }
  }
}
