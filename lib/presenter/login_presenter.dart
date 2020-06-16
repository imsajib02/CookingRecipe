import 'package:cooking_recipe/contract/login_contract.dart';
import 'package:cooking_recipe/model/user_model.dart';
import 'package:cooking_recipe/model/auth_response_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cooking_recipe/utils/variables.dart';
import 'package:cooking_recipe/utils/functions.dart';

class LoginPresenter implements Presenter{

  View _view;

  LoginPresenter(View view) {
    this._view = view;
  }

  @override
  void validateInput(BuildContext context, User user) {

    if(user.email.toString().isEmpty) {

      _view.onEmpty("Enter your email");
    }
    else {

      if(user.password.toString().isEmpty) {

        _view.onEmpty("Enter your password");
      }
      else {

        doLogin(context, user);
      }
    }
  }

  @override
  Future<void> doLogin(BuildContext context, User user) async {

    if(Variables.isConnected) {

      if(Variables.hasInternet) {

        _view.startProgressDialog(context);

        Map<String, dynamic> map = new Map();

        map["email"] = user.email.toString();
        map["password"] = user.password.toString();

        var response = await http.post(

            Uri.encodeFull(Variables.baseUrl + Variables.authURL),
            body: map,
            headers: {"Accept" : "application/json"}
        );

        if(response.statusCode == 200) {

          print(response.body);

          //AuthResponseModel authResponseModel = json.decode(response.body);

          var jsonData = json.decode(response.body);
          String response_msg = jsonData["response"];

          if(response_msg == "success") {

            String token = jsonData["result"]["token"];
            Variables.currentUser = User.fromResponse(user.email.toString(), user.password.toString(), token);

            _view.onLoginSuccess();
          }
          else if(response_msg == "error") {

            _view.stopProgressDialog();

            String message = "Invalid email/password.";
            _view.onLoginFailure(context, message);
          }
        }
        else {

          _view.stopProgressDialog();

          String message = "Login failed! Try again.";
          _view.onLoginFailure(context, message);
        }
      }
      else {

        Functions.showNoInternetSnackBar(context);
      }
    }
    else {

      Functions.showNotConnectedSnackBar(context);
    }
  }
}