import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxwithmvvm/res/Colors/AppColors.dart';
import 'package:getxwithmvvm/view_model/Services/Splash_Services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          LottieBuilder.asset("animations/rocket.json",
              frameRate: FrameRate.max),
          Center(
            child: Text(
              "Welcome_Back".tr,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              textScaleFactor: 3,
            ),
          ),
        ],
      ),
    );
  }
}
