import 'package:cooking_recipe/model/recipe_list_model.dart';
import 'package:flutter/material.dart';

abstract class View {

  void showLoadingView();
  void showRecipeListView(List<Recipe> recipeList);
  void showFailedToLoadDataView();
}

abstract class Presenter {

  void getAllRecipe(BuildContext context);
}