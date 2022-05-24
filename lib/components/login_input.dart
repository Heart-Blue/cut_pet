import 'package:cute_pet/config/app_colors.dart';
import 'package:cute_pet/controllers/app_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final double leftWidth;
  final String leftTitle;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool autofocus;
  final bool showObscure; //是否显示密码眼睛
  final String? hintText; //提示
  final ValueChanged<String> onChanged;
  final Function onCloseed;
  final ValueChanged<String>? onSubmitted;
  const LoginInput(
      {Key? key,
      required this.controller,
      required this.focusNode,
      this.leftWidth = 60,
      this.keyboardType = TextInputType.text,
      required this.leftTitle,
      this.maxLength = 100,
      this.autofocus = false,
      this.showObscure = false,
      this.hintText,
      required this.onChanged,
      required this.onCloseed,
      this.onSubmitted})
      : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  bool _isShowClosedIcon = false; //是否显示关闭按钮
  bool _securityText = true; //密码是否明文
  final _appThemeController = Get.find<AppThemeController>();
  
  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      _isShowClosedIcon = true;
    }
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          if (widget.controller.text.isNotEmpty) {
            _isShowClosedIcon = true;
          } else {
            _isShowClosedIcon = false;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
      child: Row(
        children: [
          SizedBox(
            width: widget.leftWidth,
            child: Text(
              widget.leftTitle,
              style: TextStyle(
                  fontSize: 32.sp, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              suffixIcon: getSuffi(),
              counterText: '',
            ),
            controller: widget.controller,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            minLines: 1,
            autofocus: widget.autofocus,
            keyboardType: widget.keyboardType,
            obscureText: _securityText,
            onChanged: widget.onChanged,
          ))
        ],
      ),
    );
  }

  Widget getSuffi() {
    return SizedBox(
      width: 110.w,
      child: GetBuilder(
        init: _appThemeController,
        builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                  visible: _isShowClosedIcon,
                  child: InkWell(
                      onTap: () {
                        widget.controller.text = '';
                        widget.onCloseed();
                      },
                      child: Image.asset(
                        'assets/images/login_clean.png',
                        width: 28.w,
                        color: AppColors.appthemeColor(_appThemeController.themeMark),
                      ))),
              Visibility(
                  visible: widget.showObscure,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            _securityText = !_securityText;
                          });
                        },
                        child: Image.asset(
                          _securityText
                              ? 'assets/images/login_eye_un.png'
                              : 'assets/images/login_eye.png',
                          width: 40.w,
                          color: AppColors.appthemeColor(_appThemeController.themeMark),
                        )),
                  ))
            ],
          );
        },
      ),
    );
  }
}
