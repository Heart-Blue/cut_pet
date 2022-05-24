import 'package:cute_pet/root_page.dart';
import 'package:cute_pet/views/find/find_video_list.dart';
import 'package:cute_pet/views/home/home_condition_detail.dart';
import 'package:cute_pet/views/home/home_edit_pet.dart';
import 'package:cute_pet/views/home/home_recommend_detail.dart';
import 'package:cute_pet/views/home/home_pet_list.dart';
import 'package:cute_pet/views/login/login_page.dart';
import 'package:cute_pet/views/profile/setting.dart';
import 'package:cute_pet/views/topic/topic_detail.dart';
import 'package:cute_pet/views/topic/topic_index.dart';
import 'package:cute_pet/views/topic/topic_pet_more.dart';
import 'package:cute_pet/views/welcome/lauch_page.dart';
import 'package:cute_pet/views/welcome/welcome_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  // 默认路由
  static String initialWelcome =  '/lauch';
  static String initialLauch =  '/welcome';
  // 路由列表
  static List<GetPage<dynamic>> routePages = [
    GetPage(name: '/lauch', page:()=> const LaunchPage()),
    GetPage(name: '/welcome', page:()=> const WelcomePage()),
    GetPage(name: '/root', page:()=> const RootPage()),
    GetPage(name: '/login', page:()=> LoginPage()),
    GetPage(name: '/setting', page:()=> const SettingPage()),
    GetPage(name: '/editPet', page:()=> const HomeEditPet()),
    GetPage(name: '/petList', page:()=> HomePetList()),
    GetPage(name: '/homeRecommendDetail', page:()=> HomeRecommendDetail()),
    GetPage(name: '/findVideoList', page:()=> FindVideoList()),
    GetPage(name: '/homeConditionDetail', page:()=> HomeConditionDetail()),
    GetPage(name: '/topicIndex', page:()=> const TopicIndex()),
    GetPage(name: '/topicPetMore', page:()=> TopicPetMore()),
    GetPage(name: '/topicDetail', page:()=> TopicDetail()),
  ];
}