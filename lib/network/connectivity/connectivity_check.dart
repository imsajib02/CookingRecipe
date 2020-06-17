import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cooking_recipe/utils/variables.dart';

class CheckConnectivity {

  StreamSubscription<ConnectivityResult> connectionChecker;
  StreamSubscription<DataConnectionStatus> internetAvailability;

  startChecking(BuildContext context) async {

    connectionChecker = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {

      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {

        Variables.isConnected = true;

        internetAvailability = DataConnectionChecker().onStatusChange.listen((status) {

          switch (status) {

            case DataConnectionStatus.connected:
              Variables.hasInternet = true;
              break;

            case DataConnectionStatus.disconnected:
              Variables.hasInternet = false;
              break;
          }
        });
      }
      else {

        Variables.isConnected = false;
        Variables.hasInternet = false;
      }
    });
  }

  stopChecking()
  {
    try {
      connectionChecker.cancel();
      internetAvailability.cancel();
    }
    catch(error) {
      //print(error);
    }
  }
}