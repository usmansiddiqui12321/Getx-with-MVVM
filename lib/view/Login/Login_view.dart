import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxwithmvvm/Utils/Utils.dart';
import 'package:getxwithmvvm/res/Colors/AppColors.dart';
import 'package:getxwithmvvm/res/Components/RoundButton.dart';
import 'package:getxwithmvvm/view_model/Controller/UserPreference/user_preference_View_Model.dart';
import 'package:getxwithmvvm/view_model/Controller/login/loginView_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginVM = Get.put(LoginViewModel());
  UserPreference userPreference = UserPreference();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    loginVM.emailController;
    loginVM.passwordController;
    loginVM.emailFocusNode;
    loginVM.passwordFocusNode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          title: const Text(
            'Login Page',
            textScaleFactor: 1.4,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text("🚀", style: TextStyle(fontSize: 80)),
              const SizedBox(height: 60),
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          enabled: true,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            hintText: 'email_hint'.tr,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Get.isDarkMode
                                      ? Colors.grey
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Get.isDarkMode
                                      ? Colors.grey
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          controller: loginVM.emailController.value,
                          focusNode: loginVM.emailFocusNode.value,
                          validator: (value) {},
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context,
                                loginVM.emailFocusNode.value,
                                loginVM.passwordFocusNode.value);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          enabled: true,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            hintText: 'password_hint'.tr,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Get.isDarkMode
                                      ? Colors.grey
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Get.isDarkMode
                                      ? Colors.grey
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          controller: loginVM.passwordController.value,
                          focusNode: loginVM.passwordFocusNode.value,
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              print("Error");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
              Obx(
                () {
                  return RoundButton(
                      loading: loginVM.loading.value,
                      onpress: () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          loginVM.login();
                        }
                      },
                      title: "Login");
                },
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
