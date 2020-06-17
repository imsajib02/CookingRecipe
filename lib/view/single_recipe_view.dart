import 'package:cooking_recipe/model/recipe_list_model.dart';
import 'package:flutter/material.dart';
import 'package:cooking_recipe/utils/size_config.dart';
import 'package:cooking_recipe/utils/bounce_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleRecipeView extends StatefulWidget {

  final Recipe _recipe;
  final Image _recipeImage;
  final Image _sourceImage;

  SingleRecipeView(this._recipe, this._recipeImage, this._sourceImage);

  @override
  _SingleRecipeViewState createState() => _SingleRecipeViewState();
}

class _SingleRecipeViewState extends State<SingleRecipeView> {

  Color _ingredientsSelectionColor = Colors.lightBlueAccent;
  Color _instructionSelectionColor = Colors.transparent;
  Color _sourceSelectionColor = Colors.transparent;

  Widget _widgetBody;

  @override
  void initState() {

    super.initState();
    _widgetBody = loadIngredientView();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Flexible(
              child: Container(
                width: double.infinity,
                height: 30 * SizeConfig.heightSizeMultiplier,
                child: ClipRRect(
                  child: Image(image: widget._recipeImage.image, fit: BoxFit.fill,),
                ),
              ),
            ),

            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 8, left: 12, right: 12),
                child: Text(widget._recipe.recipeTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 2 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 2, bottom: 3, left: 15, right: 12),
                child: Text(widget._recipe.source.sourceName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 1.65 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Flexible(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Flexible(
                      flex: 1,
                      child: Row(
                        children: <Widget>[

                          Icon(Icons.access_time, size: 3.5 * SizeConfig.imageSizeMultiplier,),

                          SizedBox(width: 1.5 * SizeConfig.widthSizeMultiplier,),

                          Text((widget._recipe.totalTime / 60).abs() < 1.0 ?
                          (widget._recipe.totalTime <= 1 ? widget._recipe.totalTime.toString() + "  min" : widget._recipe.totalTime.toString() + "  mins") :
                          ((widget._recipe.totalTime / 60).abs() == 1.0 ? (widget._recipe.totalTime / 60).abs().toString() + "  hr" : (widget._recipe.totalTime / 60).abs().toString() + "  hrs"),
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 3 * SizeConfig.widthSizeMultiplier,),

                    Flexible(
                      flex: 2,
                      child: Text(widget._recipe.servings <= 1 ?
                      widget._recipe.servings.toString() + " person" :
                      widget._recipe.servings.toString() + " persons",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

            Divider(height: 1, color: Colors.black26,),

            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Flexible(
                            child: GestureDetector(
                              onTap: () {

                                if(_ingredientsSelectionColor != Colors.lightBlueAccent) {

                                  setState(() {

                                    _ingredientsSelectionColor = Colors.lightBlueAccent;
                                    _instructionSelectionColor = Colors.transparent;
                                    _sourceSelectionColor = Colors.transparent;

                                    _widgetBody = loadIngredientView();
                                  });
                                }
                              },
                              child: Text("Ingredients",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 2 * SizeConfig.textSizeMultiplier,
                                ),
                              ),
                            ),
                          ),

                          Flexible(
                            child: Container(
                              width: 7.69 *SizeConfig.widthSizeMultiplier,
                              height: .1875 *SizeConfig.heightSizeMultiplier,
                              margin: EdgeInsets.only(top: 3),
                              color: _ingredientsSelectionColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Flexible(
                            child: GestureDetector(
                              onTap: () {

                                if(_instructionSelectionColor != Colors.lightBlueAccent) {

                                  setState(() {

                                    _ingredientsSelectionColor = Colors.transparent;
                                    _instructionSelectionColor = Colors.lightBlueAccent;
                                    _sourceSelectionColor = Colors.transparent;

                                    _widgetBody = loadInstructionView();
                                  });
                                }
                              },
                              child: Text("Instructions",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 2 * SizeConfig.textSizeMultiplier,
                                ),
                              ),
                            ),
                          ),

                          Flexible(
                            child: Container(
                              width: 7.69 *SizeConfig.widthSizeMultiplier,
                              height: .1875 *SizeConfig.heightSizeMultiplier,
                              margin: EdgeInsets.only(top: 3),
                              color: _instructionSelectionColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Flexible(
                            child: GestureDetector(
                              onTap: () {

                                if(_sourceSelectionColor != Colors.lightBlueAccent) {

                                  setState(() {

                                    _ingredientsSelectionColor = Colors.transparent;
                                    _instructionSelectionColor = Colors.transparent;
                                    _sourceSelectionColor = Colors.lightBlueAccent;

                                    _widgetBody = loadSourceView();
                                  });
                                }
                              },
                              child: Text("Source",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 2 * SizeConfig.textSizeMultiplier,
                                ),
                              ),
                            ),
                          ),

                          Flexible(
                            child: Container(
                              width: 7.69 *SizeConfig.widthSizeMultiplier,
                              height: .1875 *SizeConfig.heightSizeMultiplier,
                              margin: EdgeInsets.only(top: 3),
                              color: _sourceSelectionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Divider(height: 1, color: Colors.black26,),

            Flexible(child: _widgetBody,),
          ],
        ),
      ),
    );
  }

  Widget loadIngredientView() {

    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: widget._recipe.ingredientList.length == null ? 0 : widget._recipe.ingredientList.length,
      itemBuilder: (BuildContext context, int index) {

        return Padding(
          padding: EdgeInsets.only(left: 40, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Flexible(
                child: Text(widget._recipe.ingredientList[index].ingredientName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 3 * SizeConfig.textSizeMultiplier,
                  ),
                ),
              ),

              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 3, left: 15),
                  child: Text("▪ Description:  " + (widget._recipe.ingredientList[index].description == null ?
                    "- - -" : widget._recipe.ingredientList[index].description),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      wordSpacing: 1,
                      height: 1.3,
                      color: Colors.black87,
                      fontSize: 2 * SizeConfig.textSizeMultiplier,
                    ),
                  ),
                ),
              ),

              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 2, bottom: 3, left: 15),
                  child: Text("▪ Preparation:  " + (widget._recipe.ingredientList[index].preparation == null ?
                  "- - -" : widget._recipe.ingredientList[index].preparation),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      wordSpacing: 1,
                      height: 1.3,
                      color: Colors.black87,
                      fontSize: 2 * SizeConfig.textSizeMultiplier,
                    ),
                  ),
                ),
              ),

              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 2, left: 15),
                  child: Text("▪ Unit:  " + (int.parse(widget._recipe.ingredientList[index].displayQuantity) == 1 ?
                    widget._recipe.ingredientList[index].displayQuantity + "  " + widget._recipe.ingredientList[index].unit.unitName :
                    widget._recipe.ingredientList[index].displayQuantity + "  " + widget._recipe.ingredientList[index].unit.namePlural),
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black87, fontSize: 2 * SizeConfig.textSizeMultiplier),
                  ),
                ),
              ),

              SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

              Divider(height: 1, color: Colors.black45,),

              SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),
            ],
          ),
        );
      }
    );
  }

  Widget loadInstructionView() {

    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: widget._recipe.directionList.length == null ? 0 : widget._recipe.directionList.length,
        itemBuilder: (BuildContext context, int index) {

          return Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Flexible(
                  child: Text("Step " +widget._recipe.directionList[index].stepNo.toString(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 2 * SizeConfig.textSizeMultiplier,
                    ),
                  ),
                ),

                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("▪  " + widget._recipe.directionList[index].stepText,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        wordSpacing: 1,
                        height: 1.5,
                        color: Colors.black87,
                        fontSize: 2 * SizeConfig.textSizeMultiplier,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 4.375 * SizeConfig.heightSizeMultiplier,),
              ],
            ),
          );
        }
    );
  }

  Widget loadSourceView() {

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        SizedBox(height: 6.25 * SizeConfig.heightSizeMultiplier,),

        Flexible(
          child: Container(
            width: double.infinity,
            height: 20 * SizeConfig.heightSizeMultiplier,
            padding: EdgeInsets.only(left: 50, right: 50, bottom: 30),
            child: ClipRRect(
              child: Image(image: widget._sourceImage.image, fit: BoxFit.fill,),
            ),
          ),
        ),

        SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

        Flexible(
          child: BounceAnimation(
            childWidget: Container(
              child: RaisedButton(
                padding: EdgeInsets.all(10),
                elevation: 5,
                onPressed: () {

                  _launchURL(widget._recipe.sourceURL);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0),
                ),
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                child: Text("VISIT WEBPAGE", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 2.25 * SizeConfig.textSizeMultiplier,
                ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {

    if(await canLaunch(url)) {

      await launch(url);
    }
    else {

      throw 'Could not launch $url';
    }
  }
}