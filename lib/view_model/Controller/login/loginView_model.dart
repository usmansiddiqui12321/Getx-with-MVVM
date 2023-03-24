import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxwithmvvm/res/Colors/AppColors.dart';
import 'package:getxwithmvvm/res/Routes/Routes_name.dart';

import '../../../Repository/LoginRepository/login_repository.dart';
import '../../../Utils/Utils.dart';
import '../../../model/loginModel/login_api_model.dart';
import '../UserPreference/user_preference_View_Model.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();
  UserPreference userPreference = UserPreference();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  RxBool loading = false.obs;

  void login() {
    if (emailController.value.text.isEmpty ||
        passwordController.value.text.isEmpty) {
      Utils.snackBar('Login', 'Please enter Email and Password', Colors.red,
          Colors.white, SnackPosition.TOP);
      return;
    }
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text
    };
    _api.loginApi(data).then((value) {
      loading.value = false;
      if (value['error'] == 'user not found') {
        Utils.snackBar(
          'Login',
          value['error'],
          Colors.red,
          Colors.white,
          SnackPosition.TOP,
        );
      } else {
        userPreference.saveUser(UserModel.fromJson(value)).then((value) {
          Get.toNamed(RoutesName.homepage);
          if (kDebugMode) {
            print(userPreference.toString());
          }
          Get.snackbar("Login", "login Successfull",
              margin: const EdgeInsets.only(bottom: 10),
              colorText: AppColors.whiteColor,
              backgroundColor: const Color(0xff4BB543),
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: const Duration(seconds: 2));
        }).onError((error, stackTrace) {});
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar('error', error.toString(), Colors.red, Colors.white,
          SnackPosition.TOP);
    });
  }
}
