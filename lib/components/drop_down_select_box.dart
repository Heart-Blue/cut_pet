// ignore_for_file: unnecessary_this

import 'package:city_pickers/city_pickers.dart';
import 'package:cute_pet/components/pick_helper.dart';
import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/*
 * @Description: 下拉选择框
 * @Author: 郑景
 * @Date: 2021-02-26 11:04:54
 */

/// calendar：时间选择
/// select：单项选择
/// cascade：级联选择
/// city：省市区选择
/// none：无
enum SelectTypeIcon { calendar, select, cascade, city, none }

class DropDownSelectBox extends StatefulWidget {
  final String title;
  final String viewInfo;
  final List? dataList;
  final bool isShowView;
  final Function? onTapData;
  final SelectTypeIcon selectIcon;
  final String? defaultInfo;
  const DropDownSelectBox({
    Key? key,
    required this.title,
    required this.viewInfo,
    this.dataList,
    this.isShowView = false,
    this.onTapData,
    this.selectIcon = SelectTypeIcon.none,
    this.defaultInfo,
  }) : super(key: key);
  @override
  DropDownSelectBoxState createState() {
    return DropDownSelectBoxState();
  }
}

class DropDownSelectBoxState extends State<DropDownSelectBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: this.getReportType(widget.title, widget.viewInfo,
            selectIcon:
                widget.isShowView ? SelectTypeIcon.none : widget.selectIcon,
            defaultInfo: widget.defaultInfo!, onTapData: () async {
      // 清除焦点
      FocusScope.of(context).requestFocus(FocusNode());
      if (widget.selectIcon == SelectTypeIcon.city) {
        FocusScope.of(context).requestFocus(FocusNode());
        Result? tempResult = await CityPickers.showCityPicker(
            context: context,
            cancelWidget: Text(
              'cancel'.tr,
              style: TextStyle(fontSize: 50.sp, color: AppColors.unactive),
            ),
            confirmWidget: Text(
              'confirm'.tr,
              style: TextStyle(fontSize: 50.sp, color: AppColors.active),
            ),
            height: 220.0);
        widget.onTapData!(tempResult);
      } else if (widget.selectIcon == SelectTypeIcon.calendar) {
        PickHelper.openDateTimePicker(context, onConfirm: (picker, value) {
          String container =
              picker.adapter.text.substring(0, 16).replaceAll(', ', '-');
          widget.onTapData!(container);
        });
      } else if (widget.selectIcon == SelectTypeIcon.cascade) {
        PickHelper.openSimpleDataPicker(context,
            list: widget.dataList!, value: null, onConfirm: (picker, value) {
          String container = picker.adapter.text
              .substring(1, picker.adapter.text.length - 1)
              .replaceAll(', ', '-');
          widget.onTapData!(container);
        });
      } else if (widget.selectIcon == SelectTypeIcon.select) {
        this.showQuestionBankType(
            dicList: widget.dataList!,
            onTapOption: (dynamic dictInfoBean) {
              if (dictInfoBean != null) {
                widget.onTapData!(dictInfoBean);
              }
            });
      }
    }));
  }

  /*
   * @Description: 下拉选择框的字体
   * @Author: 郑景
   * @Date: 2021-02-26 11:04:54
   */
  String getSelectInfo(String viewInfo, String defaultInfo) {
    if (viewInfo.isEmpty) {
      if (defaultInfo.isNotEmpty) {
        return defaultInfo;
      } else {
        return "";
      }
    } else {
      return viewInfo;
    }
  }

/*
   * @Description: 下拉选择框的字体颜色
   * @Author: 郑景
   * @Date: 2021-02-26 11:04:54
   */
  Color getSelectColor(String viewInfo) {
    if (viewInfo.isEmpty) {
      return const Color.fromRGBO(166, 166, 166, 1);
    } else {
      return const Color.fromRGBO(51, 51, 51, 1);
    }
  }

  /*
   * @Description: 下拉选择框
   * @Author: 郑景
   * @Date: 2021-02-26 11:04:54
   */
  Widget getReportType(String title, String viewInfo,
      {Function? onTapData, SelectTypeIcon? selectIcon, String? defaultInfo}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(color: Color.fromRGBO(78, 78, 78, 1)),
          ),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  if (widget.isShowView) {
                    return;
                  }
                  if (onTapData != null) {
                    onTapData();
                  }
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            this.getSelectInfo(viewInfo, defaultInfo!),
                            style: TextStyle(
                              color: this.getSelectColor(viewInfo),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: selectIcon == SelectTypeIcon.calendar,
                        child: Container(
                            padding: EdgeInsets.only(
                              left: 24.w,
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: AppColors.unactive,
                              size: 20,
                            )),
                      ),
                      Visibility(
                        visible: selectIcon == SelectTypeIcon.select ||
                            selectIcon == SelectTypeIcon.cascade ||
                            selectIcon == SelectTypeIcon.city,
                        child: Container(
                            padding: EdgeInsets.only(
                              left: 24.w,
                            ),
                            child: const Icon(Icons.keyboard_arrow_down)),
                      ),
                      Visibility(
                        visible: selectIcon == SelectTypeIcon.none,
                        child: Container(
                          margin: EdgeInsets.only(left: 15.w),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  // 细横线
  static Widget infoLineWidget() {
    return const Divider(
      color: AppColors.unactive,
      height: 1,
    );
  }

  /*
   * @Description: 自定义底部弹出框
   * @Author: 郑景
   * @Date: 2021-03-03 14:50:00
   */
  void showQuestionBankType({Function? onTapOption, List? dicList}) {
    FocusScope.of(context).requestFocus(FocusNode());
    List<Widget> dictInfoItem = [];
    ListTile listTile = ListTile(
      title: const Text("请选择"),
      onTap: () {
        if (onTapOption != null) {
          onTapOption(null);
        }
        Navigator.pop(context);
        if (mounted) {
          setState(() {});
        }
      },
    );
    dictInfoItem.add(listTile);
    dictInfoItem.add(infoLineWidget());
    for (dynamic dictInfoBean in dicList!) {
      ListTile listTile = ListTile(
        title: Text(dictInfoBean),
        onTap: () {
          if (onTapOption != null) {
            onTapOption(dictInfoBean);
          }
          Navigator.pop(context);
          if (mounted) {
            setState(() {});
          }
        },
      );
      dictInfoItem.add(listTile);
      dictInfoItem.add(infoLineWidget());
    }
    dictInfoItem.removeLast();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: dictInfoItem,
          ));
        });
  }
}
