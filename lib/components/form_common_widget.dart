import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
 * @author by zj
 * @date 2021/7/15
 * @desc 表单公共插件
 * @class FormCommonWidget
 * @param {String} title 标题
 * @param {String} hintText 同TextFormField的hintText
 * @param {Function} onChanged 同TextFormField的onChanged
 * @param {Function} onPressed 同TextFormField的onPressed
 * @param {Function} onVoicePressed 语音
 * @param {Function} onSelectPressed 选择弹窗
 * @param {Function} onCalendarPressed 日历的弹窗
 * @param {TextEditingController} controller 控制器，需要自己传进来
 * @param {FocusNode} focus focus需要自己传进来
 * @param {bool} readOnly 输入框是否设置只读
 * @param {String} showIconType 输入框右侧的图标类型：voice:显示语音 select:显示选项 calendar:日历
 * @return {返回值类型} 返回值说明
 */
class FormCommonWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final Function? onChanged;
  final Function? onSaved;
  final Function? onPressed;
  final Function? onVoicePressed;
  final Function? onSelectPressed;
  final Function? onCalendarPressed;
  final dynamic controller;
  final dynamic focus;
  final String? showIconType;
  final bool readOnly;
  const FormCommonWidget({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.focus,
    this.onChanged,
    this.onPressed,
    this.onVoicePressed,
    this.showIconType,
    this.onSelectPressed,
    this.onCalendarPressed,
    this.onSaved,
    this.readOnly = false,
  }) : super(key: key);
  @override
  FormCommonWidgetState createState() {
    return FormCommonWidgetState();
  }
}

class FormCommonWidgetState extends State<FormCommonWidget> {
  /*
   * @author by zq
   * @date 2020/10/23
   * @desc 右侧图标的展示类型
   * @method showIconTypeFun
   * @param {参数类型} 参数名 参数说明
   * @return {返回值类型} 返回值说明
   */
  Widget showIconTypeFun() {
    if (widget.showIconType == 'select') {
      return InkWell(
        onTap: () => widget.onSelectPressed!(),
        child: const Icon(Icons.keyboard_arrow_down,size: 20,),
      );
    } else if (widget.showIconType == 'calendar') {
      return InkWell(
        onTap: () => widget.onCalendarPressed!(),
        child: const Icon(Icons.calendar_today,color: AppColors.unactive,size: 20,),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 30.w),
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Color.fromRGBO(78, 78, 78, 1)),
          ),
        ),
        Expanded(
          flex: 4,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focus,
            readOnly: widget.readOnly,
            minLines: 1,
            maxLines: 2,
            //设置键盘类型
            keyboardType: TextInputType.text,
            textAlign: TextAlign.right,
            style: const TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1)),
            onChanged: (val) {
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
            onSaved: (val) {
              if (widget.onSaved != null) {
                widget.onSaved!(val);
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color:  const Color.fromRGBO(166, 166, 166, 1),
                fontSize: 26.sp
              ),
            ),
          ),
        ),
        Visibility(
            visible: widget.showIconType == 'select' ||
                    widget.showIconType == 'calendar'
                ? true
                : false,
            child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: 30.w),
                child: showIconTypeFun())),
      ],
    );
  }
}
