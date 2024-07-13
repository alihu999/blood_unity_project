import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<DateTime?> selectDateDialog() {
  return showDatePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
}

Future<TimeOfDay?> selectTime() {
  return showTimePicker(
      context: Get.context!, initialTime: const TimeOfDay(hour: 0, minute: 0));
}
