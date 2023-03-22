import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getxwithmvvm/res/Routes/Routes_name.dart';
import 'package:getxwithmvvm/view_model/Controller/UserPreference/user_preference_View_Model.dart';

class SplashServices {
  late bool islogin;
  UserPreference userPreference = UserPreference();
  void isLogin() {
    islogin = false;
    userPreference.getUser().then((value) {
      if (kDebugMode) {
        print(value.token);
      }
      if (value.token != null && value.token!.isNotEmpty) {
        Timer(
          const Duration(seconds: 3),
          () => Get.toNamed(
            RoutesName.homepage,
          ),
        );
        islogin = true;
      } else {
        Timer(
          const Duration(seconds: 3),
          () => Get.toNamed(
            RoutesName.loginView,
          ),
        );
        islogin = true;
      }
    });
  }
}
