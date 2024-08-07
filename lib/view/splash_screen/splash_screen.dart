import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/retrofit/local/local_services.dart';
import 'package:task/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (LocalServices.isUserLoggedIn()) {
          Get.offNamed(Routes.homePage);
        } else {
          Get.offNamed(Routes.mainAuth);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
