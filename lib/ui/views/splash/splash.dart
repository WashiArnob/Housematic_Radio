
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:housematic_radio/ui/responsive/size_config.dart';
import 'package:housematic_radio/ui/route/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final box = GetStorage();
  chooseScreen() {
    var value = box.read('uid');
    if (value == null) {
      Get.toNamed(onboarding);
    } else {
      Get.toNamed(bottomNavController);
    }
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () => chooseScreen(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/files/splash.gif',
          width: SizeConfig.screenWidth! / 1.5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
