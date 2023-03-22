import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxwithmvvm/Utils/Utils.dart';
import 'package:getxwithmvvm/res/Colors/AppColors.dart';
import 'package:getxwithmvvm/res/Components/RoundButton.dart';
import 'package:getxwithmvvm/view_model/Controller/login/loginView_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginVM = Get.put(LoginViewModel());
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
          title: Text(
            'login'.tr,
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
                              hintText: 'email_hint'.tr,
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12))),
                          controller: loginVM.emailController.value,
                          focusNode: loginVM.emailFocusNode.value,
                          onFieldSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context,
                                loginVM.emailFocusNode.value,
                                loginVM.passwordFocusNode.value);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          enabled: true,
                          decoration: InputDecoration(
                              hintText: 'password_hint'.tr,
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12))),
                          controller: loginVM.passwordController.value,
                          focusNode: loginVM.passwordFocusNode.value,
                          onFieldSubmitted: (value) {},
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
                  const Text(
                    'Don\'t have an account?',
                    textScaleFactor: 1.2,
                    style: TextStyle(color: AppColors.primaryColor),
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
