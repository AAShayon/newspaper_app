import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationService {
  static final NavigationService _navigationService = NavigationService._internal();
  NavigationService._internal();
  static NavigationService get instance => _navigationService;

  static Future<dynamic>? navigateTo(String routeName) {
    return Get.toNamed(routeName);
  }

  static Future<dynamic>? navigateToReplacement(String routeName) {
    return Get.offNamed(routeName);
  }

  static Future<dynamic>? navigateToUntilReplacement(String routeName) {
    return Get.offAllNamed(routeName);
  }

  static Future<dynamic>? popAndReplace(String routeName) async {
    return Get.offNamed(routeName);
  }


  static Future<dynamic>? navigateToWithArgs(String routeName, Map<String, dynamic>? args) {
    return Get.toNamed(routeName, arguments: args);
  }

  static Future<dynamic>? popAndReplaceWihArgs(String routeName, Map<String, dynamic>? args) {
    return Get.offNamed(routeName, arguments: args);
  }

  static Future<dynamic>? navigateToWithObject(String routeName, Object? obj) {
    return Get.toNamed(routeName, arguments: obj);
  }

  static void goBack() {
    Get.back();
  }
  static void popUntilRoot() {
    Get.offAllNamed('/');
  }

  static bool canGoBack() {
    return Get.isOverlaysOpen || Get.currentRoute != '/';
  }

  static BuildContext? get context => Get.context;
}