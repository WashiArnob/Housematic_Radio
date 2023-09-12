import 'package:get/get.dart';
import 'package:housematic_radio/ui/views/auth/forgot_password.dart';
import 'package:housematic_radio/ui/views/auth/login.dart';
import 'package:housematic_radio/ui/views/auth/registration.dart';
import 'package:housematic_radio/ui/views/home/bottom_nav_controller.dart';
import 'package:housematic_radio/ui/views/home/features/player_screen.dart';
import 'package:housematic_radio/ui/views/home/tabs/playlist_tab.dart';
import 'package:housematic_radio/ui/views/onboarding/onboarding_screen.dart';

import '../views/splash/splash.dart';

const String splash = '/splash';
const String onboarding = '/onbording';
const String login = '/login';
const String registration = '/registration';
const String forgotPassword = '/forgotPassword';
const String bottomNavController = '/bottomNavController';
const String playerScreen = '/playerScreen';
const String playlistItems = '/playlistItems';

List<GetPage> getPages = [
  GetPage(
    name: splash,
    page: () => Splash(),
  ),
  GetPage(
    name: onboarding,
    page: () => OnboardingScreen(),
  ),
  GetPage(
    name: login,
    page: () => Login(),
  ),
  GetPage(
    name: registration,
    page: () => Registration(),
  ),
  GetPage(
    name: forgotPassword,
    page: () => ForgotPassword(),
  ),
  GetPage(
    name: bottomNavController,
    page: () => BottomNavController(),
  ),
  GetPage(
    name: playerScreen,
    page: () => PlayerScreen(data: Get.arguments,),
  ),
  GetPage(
    name: playlistItems,
    page: () => PlayListItems(category: Get.arguments,),
  ),
];
