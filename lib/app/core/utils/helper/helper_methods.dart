import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:app_settings/app_settings.dart';

import '../../../config/injection/di.dart';
import '../../../config/theme/color.dart';
import '../../constants/app_constants.dart';
import '../../../config/router/navigation_service.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}
void initiateInternetChecker() {
  InternetConnectionChecker.createInstance().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        break;
      case InternetConnectionStatus.disconnected:
        if (NavigationService.context != null) {
          buildShowNoInternetDialog(NavigationService.context!, () {});
        }
        break;
      case InternetConnectionStatus.slow:
        log("Internet connection is slow.");
        break;
    }
  });
}


void setStatusBarWithRotation(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor(context),
      statusBarIconBrightness:
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}


Future<void> setInitValue() async {
  await appData.writeIfNull(kKeyIsLoggedIn, false);
}

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text(""),
      content: const Text("Are you sure you want to exit the app?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(true);
            await Future.delayed(const Duration(milliseconds: 100));
            if (Platform.isAndroid || Platform.isIOS) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
          child: const Text("Exit"),
        ),
      ],
    ),
  ) ?? false;
}

Future<dynamic> buildShowNoInternetDialog(
    BuildContext context, Function onDismiss) {
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: const Text('No Internet Connection'),
      content: const Text(
        'You are not connected to the internet. Please enable Wi-Fi or mobile data to proceed.',
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
            onDismiss();
          },
        ),
        CupertinoDialogAction(
          child: const Text('Open WiFi'),
          onPressed: () {
            Navigator.pop(context);
            onDismiss();
            AppSettings.openAppSettings(type: AppSettingsType.wifi);

          },
        ),
      ],
    ),
  );
}


