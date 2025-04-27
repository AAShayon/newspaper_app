import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/theme/color.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
Future<bool> isConnectedToInternet() async {
  // Check connectivity status
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false; // No network connection
  }

  // Verify internet access by pinging a reliable server
  try {
    final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 5));
    return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
  } catch (_) {
    return false; // Unable to reach the internet
  }
}

/// Shows a dialog when there's no internet connection.
Future<void> showNoInternetDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
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
          },
        ),
      ],
    ),
  );
}


