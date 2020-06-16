import 'package:flutter/material.dart';
import 'dart:io';
import 'package:system_setting/system_setting.dart';

import 'package:cooking_recipe/utils/size_config.dart';

class Functions {

  static void showNotConnectedSnackBar(BuildContext context) {

    var snackbar;

    if (Platform.isAndroid) {

      snackbar = SnackBar(
        content: Text("Turn on mobile data/wifi.",
          style: TextStyle(fontSize: 1.8 * SizeConfig.textSizeMultiplier, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        elevation: 3.0,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Go',
          onPressed: () {
            SystemSetting.goto(SettingTarget.WIFI);
          },
        ),
      );

      Scaffold.of(context).showSnackBar(snackbar);
    }
    else if (Platform.isIOS) {

      snackbar = SnackBar(
        content: Text("Turn on mobile data/wifi.",
          style: TextStyle(fontSize: 1.8 * SizeConfig.textSizeMultiplier, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        elevation: 3.0,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      );

      Scaffold.of(context).showSnackBar(snackbar);
    }
  }


  static void showNoInternetSnackBar(BuildContext context) {

    final snackbar = SnackBar(
      content: Text("No internet",
        style: TextStyle(fontSize: 1.8 * SizeConfig.textSizeMultiplier, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    );

    Scaffold.of(context).showSnackBar(snackbar);
  }
}