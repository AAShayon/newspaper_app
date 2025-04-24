import 'dart:io';
import 'package:get/get.dart';
import 'package:newspaper_app/app/feature/auth/presentation/bindings/auth_binding.dart';
import 'package:newspaper_app/app/feature/auth/presentation/screen/login.dart';
import 'package:newspaper_app/app/feature/auth/presentation/screen/register.dart';
import '../../feature/home/presentation/screens/home.dart';
import '../../feature/initial/presentation/screens/splash_screen.dart';

class AppPages {
  static final AppPages _routes = AppPages._internal();
  AppPages._internal();
  static AppPages get instance => _routes;

  static const String loading = '/loading';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login= '/login';
  static const String registration = '/registration';
  static const String details = '/details';
  static const String bookmark='/bookmark';

  // Define GetPages with platform-specific transitions
  static final List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () =>  SplashScreen(),
      transition: Platform.isIOS ? Transition.cupertino : Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500), // Optional
      binding: AuthBinding()
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 500),
      // binding: HomeScreenBindings()
    ),
    GetPage(
      name: login,
      page: () =>  LoginScreen(),
      transition: Platform.isIOS ? Transition.cupertino : Transition.zoom,
      transitionDuration: const Duration(milliseconds: 500),
      binding:AuthBinding()
    ),
    GetPage(
        name: registration,
        page: () =>  RegisterScreen(),
        transition: Platform.isIOS ? Transition.cupertino : Transition.zoom,
        transitionDuration: const Duration(milliseconds: 500),
        binding:AuthBinding()
    ),
  ];
}