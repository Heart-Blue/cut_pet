import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetLoadImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final String defaultImgUrl;
  const NetLoadImage(
      {Key? key,
      required this.imageUrl,
      this.width = 0,
      this.height = 0,
      this.defaultImgUrl = 'assets/images/animal_dog.png'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            width: width == 0 ? 75.w : width,
            height: height == 0 ? 75.w : height,
            // 图片地址
            imageUrl: imageUrl,
            // 填充方式为cover
            fit: BoxFit.cover,
            // 加载样式为IOS的加载，居中显示
            placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            // 加载失败后显示自定义的404图片
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/find_empty_img.png',
              fit: BoxFit.cover,
            ),
            fadeOutDuration: const Duration(milliseconds: 300),
            fadeInDuration: const Duration(milliseconds: 700),
          )
        // 默认的加载图片
        : Image.asset(
            defaultImgUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
  }
}
