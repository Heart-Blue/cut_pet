import 'package:carousel_slider/carousel_slider.dart';
import 'package:cute_pet/controllers/home_video_detail_controller.dart';
import 'package:cute_pet/views/find/find_video_play.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FindVideoList extends StatelessWidget {
  FindVideoList({Key? key}) : super(key: key);
  final homeVideoDetailController = Get.find<HomeVideoDetailController>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [renderCarouselSlider()],
        ),
      ),
    );
  }

  Widget renderCarouselSlider() {
    return Container(
      color: Colors.black,
      child: GetBuilder(
          init: homeVideoDetailController,
          builder: (_) {
            return CarouselSlider.builder(
              itemCount: homeVideoDetailController.videoList.length,
              options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  height: Get.height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      homeVideoDetailController.onPageChanged(index)),
              itemBuilder: (BuildContext ctx, int index, int y) {
                if (homeVideoDetailController.videoList.length <= index) {
                  return Container();
                }
                return FindVideoPlay(
                    key: ValueKey(index),
                    homeVideoItemModel:
                        homeVideoDetailController.videoList[index],
                    actionCallback: (type) {});
              },
            );
          }),
    );
  }
}
