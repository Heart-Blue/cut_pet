import 'package:cute_pet/utils/shared_preferences_utils.dart';
import 'package:cute_pet/models/login_info_model.dart';

class SharedStorage {
  // 缓存Welcome
  static saveWelcome() {
    SharedPreferencesUtils.savePreference('welcome', true);
  }

  //读取Welcome
  static Future getWelcome() async {
    bool welcome =
        await SharedPreferencesUtils.getPreference('welcome', bool) ?? false;
    return welcome;
  }

  // 清除Welcome
  static cleanWelcome() {
    SharedPreferencesUtils.remove('welcome');
  }

  //缓存token
  static saveToken(String token) {
    SharedPreferencesUtils.savePreference('authorization', token);
  }

  //读取token
  static Future getToken() async {
    String token =
        await SharedPreferencesUtils.getPreference('authorization', String) ??
            '';
    return token;
  }

  //清除token
  static cleanToken() {
    SharedPreferencesUtils.remove('authorization');
  }

  //缓存用户信息
  static saveUserInfo(
      {required int userId,
      required String userPhone,
      required String nickname,
      required String headImg}) {
    SharedPreferencesUtils.savePreference('userId', userId);
    SharedPreferencesUtils.savePreference('userPhone', userPhone);
    SharedPreferencesUtils.savePreference('nickname', nickname);
    SharedPreferencesUtils.savePreference('headImg', headImg);
  }

  //读取用户信息
  static Future getUserInfo() async {
    int userInfoId =
        await SharedPreferencesUtils.getPreference('userId', int) ?? 0;
    String userInfoPhone =
        await SharedPreferencesUtils.getPreference('userPhone', String) ?? '';
    String userInfoName =
        await SharedPreferencesUtils.getPreference('nickname', String) ?? '';
    String userInfoHeadImg =
        await SharedPreferencesUtils.getPreference('headImg', String) ?? '';
    return LoginProfileInfoModel(
        userId: userInfoId,
        userPhone: userInfoPhone,
        nickname: userInfoName,
        headImg: userInfoHeadImg);
  }

  // 清除用户信息
  static cleanUserInfo() {
    SharedPreferencesUtils.remove('userId');
    SharedPreferencesUtils.remove('userPhone');
    SharedPreferencesUtils.remove('nickname');
    SharedPreferencesUtils.remove('headImg');
  }

  // 缓存登录的用户名和密码
  static saveLoginInfo({required String account, required String password}) {
    SharedPreferencesUtils.savePreference('username', account);
    SharedPreferencesUtils.savePreference('password', password);
  }

  // 读取登录的用户名和密码
  static getLoginInfo() async {
    Map loginInfo = {};
    loginInfo['username'] =
        await SharedPreferencesUtils.getPreference('username', String) ?? '';
    loginInfo['password'] =
        await SharedPreferencesUtils.getPreference('password', String) ?? '';
    return loginInfo;
  }

  // 清除登录的用户名和密码
  static cleanLoginInfo() {
    SharedPreferencesUtils.remove('username');
    SharedPreferencesUtils.remove('password');
  }

  // 清空缓存
  static cleanCache() {
    SharedPreferencesUtils.clear();
  }
}
