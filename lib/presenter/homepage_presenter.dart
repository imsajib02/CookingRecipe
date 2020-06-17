import 'dart:convert';
import 'dart:io';

import 'package:cooking_recipe/contract/homepage_contract.dart';
import 'package:cooking_recipe/model/recipe_list_model.dart';
import 'package:cooking_recipe/utils/variables.dart';
import 'package:cooking_recipe/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePagePresenter implements Presenter {

  View _view;

  HomePagePresenter(View view) {
    this._view = view;
  }

  @override
  void getAllRecipe(BuildContext context) async {

    RecipeListModel recipeListModel = RecipeListModel();

    if(Variables.isConnected) {

      if(Variables.hasInternet) {

        _view.showLoadingView();

        var response = await http.get(

            Uri.encodeFull(Variables.baseUrl + Variables.recipeListURL),
            headers: {HttpHeaders.authorizationHeader: "Bearer " + Variables.currentUser.tokenID.toString(), "Accept" : "application/json"}
        );

        if(response.statusCode == 200) {

          print(response.body);

          recipeListModel = RecipeListModel.fromJson(json.decode(response.body));

          _view.showRecipeListView(recipeListModel.recipeList);
        }
        else{

          _view.showFailedToLoadDataView();
        }
      }
      else{

        _view.showFailedToLoadDataView();
        Functions.showNoInternetSnackBar(context);
      }
    }
    else{

      _view.showFailedToLoadDataView();
      Functions.showNotConnectedSnackBar(context);
    }
  }

}