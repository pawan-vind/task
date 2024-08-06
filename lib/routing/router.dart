import 'package:get/get.dart';
import 'package:task/routing/routes.dart';
import 'package:task/view/auth/main_auth.dart';
import 'package:task/view/auth/sign_in/signin.dart';
import 'package:task/view/home/home_page.dart';
import 'package:task/view/splash_screen/splash_screen.dart';

final getPage = [
  GetPage(
    name: Routes.mainAuth,
    page: () =>  MainAuth(),
  ),
    GetPage(
    name: Routes.homePage,
    page: () =>  HomePage(),
  ),
    GetPage(
    name: Routes.splashScreen,
    page: () =>  SplashScreen(),
  ),
];
