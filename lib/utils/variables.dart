import 'package:cooking_recipe/model/user_model.dart';

class Variables {

  static String baseUrl = "https://rcapp.utech.dev/api/";
  static String authURL = "auth/login";
  static String recipeListURL = "recipes";

  static User currentUser = User();

  static bool isConnected = false;
  static bool hasInternet = false;
}