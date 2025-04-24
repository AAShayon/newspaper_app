// import 'dart:io';
// import 'package:get/get.dart';
//
// class AppPages {
//   static final AppPages _routes = AppPages._internal();
//   AppPages._internal();
//   static AppPages get instance => _routes;
//
//   static const String loading = '/loading';
//   static const String splash = '/splash';
//   static const String home = '/home';
//   static const String webView = '/webView';
//   static const String searchScreen = '/searchScreen';
//   // static const String details = '/details';
//
//   // Define GetPages with platform-specific transitions
//   static final List<GetPage> routes = [
//     GetPage(
//       name: splash,
//       page: () => const SplashScreen(),
//       transition: Platform.isIOS ? Transition.cupertino : Transition.fadeIn,
//       transitionDuration: const Duration(milliseconds: 500), // Optional
//     ),
//     GetPage(
//       name: home,
//       page: () => const HomeScreen(),
//       transition: Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
//       transitionDuration: const Duration(milliseconds: 500),
//       // binding: HomeScreenBindings()
//     ),
//     GetPage(
//       name: searchScreen,
//       page: () =>  SearchScreen(),
//       transition: Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
//       transitionDuration: const Duration(milliseconds: 500),
//       // binding: HomeScreenBindings()
//     ),
//
//     GetPage(
//       name: loading,
//       page: () => const InitialLoader(),
//       transition: Platform.isIOS ? Transition.cupertino : Transition.zoom,
//       transitionDuration: const Duration(milliseconds: 500),
//     ),
//   ];
// }