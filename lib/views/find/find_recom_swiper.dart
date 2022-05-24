import 'package:cute_pet/models/find_recommend_image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class FindTopicSwiper extends StatelessWidget {
  final List<FindRecommendImageItemModel> topics;
  const FindTopicSwiper({Key? key, required this.topics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return _renderImage(index);
          },
          pagination: const SwiperPagination(),
          autoplay: true,
          loop: false,
          itemCount: topics.length),
    );
  }

  Widget _renderImage(int index) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(topics[index].labelImg), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(topics[index].labelName,
              style: const TextStyle(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelWidget(Icons.message, topics[index].userCount),
              labelWidget(Icons.remove_red_eye, topics[index].readNUm),
            ],
          )
        ],
      ),
    );
  }

  Widget labelWidget(IconData icon, int num) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30.w,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          num.toString(),
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
