
class RecipeListModel {

  List<Recipe> recipeList;

  RecipeListModel({this.recipeList});

  RecipeListModel.fromJson(Map<String, dynamic> json) {

    if(json['data'] != null) {

      recipeList = List();

      json['data'].forEach((recipe) {

        recipeList.add(Recipe.fromJson(recipe));
      });
    }
  }
}

class Recipe {

  String recipeID;
  String recipeTitle;
  int servings;
  int totalTime;
  int preparationTime;
  int cookingTime;
  String imageURL;
  String sourceURL;
  String notes;
  Source source;
  List<Ingredients> ingredientList;
  List<Direction> directionList;

  Recipe({this.recipeID, this.recipeTitle, this.servings,
    this.totalTime, this.preparationTime, this.cookingTime, this.imageURL,
    this.sourceURL, this.notes, this.source, this.ingredientList,
    this.directionList});

  Recipe.fromJson(Map<String, dynamic> json) {

    recipeID =  json['id'];
    recipeTitle =  json['title'];
    servings =  json['servings'];
    totalTime =  json['total_time'];
    preparationTime =  json['prep_time'];
    cookingTime =  json['cook_time'];
    imageURL =  json['image_url'];
    sourceURL =  json['source_url'];
    notes =  json['notes'];
    source =  json['source'] == null ? null : Source.fromJson(json['source']);

    if(json['ingredients'] != null) {

      ingredientList = List();

      json['ingredients'].forEach((ingredient) {

        ingredientList.add(Ingredients.fromJson(ingredient));
      });
    }

    if(json['directions'] != null) {

      directionList = List();

      json['directions'].forEach((direction) {

        directionList.add(Direction.fromJson(direction));
      });
    }
  }
}


class Source {

  String sourceName;
  String sourceSiteURL;
  String sourceImageURL;

  Source({this.sourceName, this.sourceSiteURL, this.sourceImageURL});

  Source.fromJson(Map<String, dynamic> json) {

    sourceName =  json['name'];
    sourceSiteURL = json['site_url'];
    sourceImageURL = json['image_url'];
  }
}


class Ingredients {

  int ingredientID;
  String ingredientName;
  String description;
  String preparation;
  String quantity;
  String displayQuantity;
  Unit unit;

  Ingredients({this.ingredientID, this.ingredientName, this.description,
    this.preparation, this.quantity, this.displayQuantity, this.unit});

  Ingredients.fromJson(Map<String, dynamic> json) {

    ingredientID =  json['id'];
    ingredientName = json['name'];
    description = json['description'];
    preparation = json['preparation'];
    quantity = json['quantity'];
    displayQuantity = json['display_quantity'];
    unit = json['unit'] == null ? null : Unit.fromJson(json['unit']);
  }
}


class Unit {

  String unitID;
  String unitName;
  String abbreviation;
  String namePlural;
  String abbreviationPlural;

  Unit({this.unitID, this.unitName, this.abbreviation, this.namePlural,
    this.abbreviationPlural});

  Unit.fromJson(Map<String, dynamic> json) {

    unitID =  json['id'];
    unitName = json['name'];
    abbreviation = json['abbreviation'];
    namePlural = json['name_plural'];
    abbreviationPlural = json['abbreviation_plural'];
  }
}


class Direction {

  int stepNo;
  String stepText;

  Direction({this.stepNo, this.stepText});

  Direction.fromJson(Map<String, dynamic> json) {

    stepNo =  json['step'];
    stepText = json['text'];
  }
}