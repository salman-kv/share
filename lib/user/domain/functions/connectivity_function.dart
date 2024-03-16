import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';

class ConnectivityFunction {
  checkingConnection({required BuildContext context}) {
    var a = Connectivity().checkConnectivity().asStream();
    a.listen((event) {
      log('---------------==================----------------');
      if (event == ConnectivityResult.other ||
          event == ConnectivityResult.none) {
        SnackBars().errorSnackBar('No internet connection', context);
      }
    });
  }
}
