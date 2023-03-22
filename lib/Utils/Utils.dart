import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../res/Colors/AppColors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).nextFocus();
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.blackColor,
        gravity: ToastGravity.BOTTOM);
  }

  static snackBar(
    String title,
    String message,
    Color backgroundColor,
    Color textColor,
    SnackPosition position,
  ) {
    Get.snackbar(title, message,
        snackPosition: position,
        backgroundColor: backgroundColor,
        colorText: textColor);
  }
}
