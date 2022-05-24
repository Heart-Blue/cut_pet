import 'package:cute_pet/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

const double _kPickerSheetHeight = 200.0;
const double _kPickerItemHeight = 30.0;
typedef PickerConfirmCityCallback = void Function(
    List<String> stringData, List<int> selecteds);

class PickHelper {
  ///普通简易选择器
  static void openSimpleDataPicker<T>(
    BuildContext context, {
    required List<T> list,
    String? title,
    required T value,
    PickerDataAdapter? adapter,
    required PickerConfirmCallback onConfirm,
  }) {
    openModalPicker(context,
        adapter: PickerDataAdapter<String>(pickerdata: list),
        onConfirm: onConfirm,
        title: title);
  }

  ///日期选择器
  static void openDateTimePicker(
    BuildContext context, {
    String? title,
    DateTime? maxValue,
    DateTime? minValue,
    DateTime? value,
    DateTimePickerAdapter? adapter,
    @required PickerConfirmCallback? onConfirm,
  }) {
    openModalPicker(context,
        adapter: adapter ??
            DateTimePickerAdapter(
                type: PickerDateTimeType.kYMDHM,
                isNumberMonth: true,
                yearSuffix: "年",
                value: value ?? DateTime.now(),
                monthSuffix: "月",
                daySuffix: "日",
                hourSuffix: "时",
                minuteSuffix: "分"),
        title: title,
        onConfirm: onConfirm!);
  }

  static void openModalPicker(
    BuildContext context, {
    required PickerAdapter adapter,
    String? title,
    List<int>? selecteds,
    required PickerConfirmCallback onConfirm,
  }) {
    Picker(
      adapter: adapter,
      title: Text(title ?? ""),
      selecteds: selecteds,
      cancelText: 'cancel'.tr,
      confirmText: 'confirm'.tr,
      cancelTextStyle:
          const TextStyle(color: AppColors.unactive, fontSize: 16.0),
      confirmTextStyle: const TextStyle(color: AppColors.active, fontSize: 16.0),
      textAlign: TextAlign.right,
      textStyle: const TextStyle(color: AppColors.unactive, fontSize: 18),
      selectedTextStyle: const TextStyle(color: AppColors.active, fontSize: 18),
      itemExtent: _kPickerItemHeight,
      height: _kPickerSheetHeight,
      onConfirm: onConfirm,
    ).showModal(context);
  }
}
