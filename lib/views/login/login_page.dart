import 'package:cute_pet/components/login_input.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:cute_pet/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _loginController.popBack,
      child: Scaffold(
        appBar: AppBar(
          title: Text('login'.tr),
        ),
        body: GestureDetector(
          onTap: () {
            // 触摸收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [headerImg(), renderPasswordContent()],
          ),
        ),
      ),
    );
  }

  Widget headerImg() {
    return GetBuilder<AppThemeController>(
      init: AppThemeController(),
      builder: (_) {
        return Container(
          height: 200.h,
          width: Get.width,
          alignment: Alignment.center,
          color: AppColors.appthemeColor(_.themeMark),
          child: Image.asset('assets/images/login_pet.png',color: Colors.white,),
        );
      },
    );
  }

  Widget renderPasswordContent() {
    return Container(
      margin: EdgeInsets.only(top: 160.h),
      decoration: BoxDecoration(
          color: const Color(0xFFf7f7f7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.w),
            topRight: Radius.circular(50.w),
          )),
      child: Column(children: [
        accountWidget(),
        passwordWidget(),
        rememberWidget(),
        loginButton()
      ]),
    );
  }

  Widget accountWidget() {
    return LoginInput(
      controller: _loginController.accountController,
      focusNode: _loginController.accountNode,
      leftTitle: 'mobile_phone_no'.tr,
      keyboardType: TextInputType.number,
      maxLength: 11,
      hintText: 'mobile_hintText'.tr,
      leftWidth: 160.w,
      onChanged: (value) {
        _loginController.account.value = value;
      },
      onCloseed: () {
        _loginController.account.value = '';
      },
    );
  }

  Widget passwordWidget() {
    return LoginInput(
      controller: _loginController.passwordController,
      focusNode: _loginController.passwordNode,
      leftTitle: 'password_phone_no'.tr,
      keyboardType: TextInputType.number,
      maxLength: 16,
      hintText: 'password_hintText'.tr,
      showObscure: true,
      leftWidth: 160.w,
      onChanged: (value) {
        _loginController.password.value = value;
      },
      onCloseed: () {
        _loginController.password.value = '';
      },
    );
  }

  Widget rememberWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GetBuilder<LoginController>(
              init: _loginController,
              id: 'rememberPwd',
              builder: (_) => Checkbox(
                    value: _.isRememberPwd,
                    onChanged: (value) {
                      _.handleRememberPwd();
                    },
                  )),
          Text(
            "rememberPassword".tr,
            style: TextStyle(
              fontSize: 30.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: Get.width,
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Obx(() => ElevatedButton(
            child: Text('login'.tr,
                style: TextStyle(fontSize: 32.sp, color: Colors.black)),
            onPressed: _loginController.password.value.length > 2 &&
                    _loginController.account.value.length > 2
                ? () {
                    _loginController.loginAction();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.w),
              ),
            ),
          )),
    );
  }
}
