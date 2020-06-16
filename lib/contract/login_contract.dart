import 'package:cooking_recipe/model/user_model.dart';
import 'package:flutter/material.dart';

abstract class View {

  void onEmpty(String message);
  void startProgressDialog(BuildContext context);
  void stopProgressDialog();
  void onLoginSuccess();
  void onLoginFailure(BuildContext context, String message);
}

abstract class Presenter {

  void validateInput(BuildContext context, User user);
  void doLogin(BuildContext context, User user);
}