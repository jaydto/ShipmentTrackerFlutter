import 'dart:io';

import 'package:shipment_tracker/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';

class AppUpdater extends StatefulWidget {
  @override
  _AppUpdaterState createState() => _AppUpdaterState();
}

class _AppUpdaterState extends State<AppUpdater> {
  late String currentAppVersion;
  late String latestAppVersion;
  bool isLoading = false;
  bool shown = false;
  bool shouldShowToast = false;

  @override
  void initState() {
    super.initState();
    checkForUpdates();
    showToast();
    appCheck();
  }

  Future<void> checkForUpdates() async {
    try {
      if (!isLoading) {
        if (Platform.isAndroid) {
          final PackageInfo packageInfo = await PackageInfo.fromPlatform();
          setState(() {
            currentAppVersion = packageInfo.version;
          });

          final response = await http
              .get('https://www.shipment_tracker.com/android/download' as Uri);
          if (response.statusCode == 200) {
            setState(() {
              latestAppVersion = response.body;
            });
          } else {
            toastification.show(
                context: context,
                title: 'Error',
                icon: const Icon(Icons.check),
                description:
                    "We're unable to establish a connection right now. Please check your internet.",
                type: ToastificationType.error,
                style: ToastificationStyle.flatColored,
                closeButtonShowType: CloseButtonShowType.always,
                autoCloseDuration: const Duration(seconds: 5));
          }
        }
      }
    } catch (e) {
      print("error: $e");
    }
  }

  void showToast() {
    final toastUpdateTimestamp = getFromLocalStorage('updateToastTimestamp');
    if (toastUpdateTimestamp == null) {
      setState(() {
        shouldShowToast = true;
      });
    } else {
      final now = DateTime.now().millisecondsSinceEpoch;
      final toastTime = int.parse(toastUpdateTimestamp as String);
      final diff = toastTime - now;
      if (diff <= 0) {
        setLocalStorage('updateToastTimestamp', null);
        setState(() {
          shouldShowToast = true;
        });
      }
    }
  }

  void appCheck() {
    if (currentAppVersion != latestAppVersion && shouldShowToast) {
      toastification.show(
          context: context,
          title: 'Info',
          icon: const Icon(Icons.check),
          description: "A new version of the app is available. Please update",
          type: ToastificationType.info,
          style: ToastificationStyle.flatColored,
          closeButtonShowType: CloseButtonShowType.always,
          autoCloseDuration: const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
