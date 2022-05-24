import 'package:cute_pet/caches/shared_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();

    return Material(
      child: PageView(
        controller: _pageController,
        children: [1, 2, 3, 4].map((e) {
          
          return GestureDetector(
            child: Image.asset('assets/images/guideX$e.png', fit: BoxFit.cover),
            onTap: () {
              if (e == 4) {
                // 缓存欢迎页成功
                SharedStorage.saveWelcome();
                Get.toNamed('/root');
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
