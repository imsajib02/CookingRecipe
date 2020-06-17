import 'package:cooking_recipe/contract/homepage_contract.dart';
import 'package:cooking_recipe/presenter/homepage_presenter.dart';
import 'package:flutter/material.dart';
import 'package:cooking_recipe/utils/variables.dart';
import 'package:cooking_recipe/utils/functions.dart';
import 'package:cooking_recipe/model/recipe_list_model.dart';
import 'package:cooking_recipe/network/connectivity/connectivity_check.dart';
import 'package:cooking_recipe/utils/size_config.dart';

class HomePageView extends StatefulWidget {

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> implements View {

  Presenter _presenter;
  Widget _widgetBody;
  BuildContext _context;

  @override
  void initState() {

    super.initState();
    _presenter = HomePagePresenter(this);
    _widgetBody = Container();
    _presenter.getAllRecipe(context);
    CheckConnectivity().startChecking(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlueAccent,),
      body: Builder(
        builder: (BuildContext context) {

          _context = context;

          return _widgetBody;
        },
      ),
    );
  }

  @override
  void showLoadingView() {

    setState(() {

      _widgetBody = Center(
          child: CircularProgressIndicator()
      );
    });
  }

  @override
  void showRecipeListView(List<Recipe> recipeList) {

    setState(() {

      _widgetBody = ListView.builder(
          itemCount: recipeList.length == null ? 0 : recipeList.length,
          itemBuilder: (BuildContext context, int index) {

            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Flexible(
                      child: Container(
                        width: double.infinity,
                        height: 30 * SizeConfig.heightSizeMultiplier,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(recipeList[index].imageURL, fit: BoxFit.contain,),
                        ),
                      ),
                    ),

                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(top: 15, bottom: 8, left: 12, right: 12),
                        alignment: Alignment.centerLeft,
                        child: Text(recipeList[index].recipeTitle,
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
                        alignment: Alignment.centerLeft,
                        child: Text(recipeList[index].source.sourceName,
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

                                  Text((recipeList[index].totalTime / 60).abs() < 1.0 ?
                                  (recipeList[index].totalTime <= 1 ? recipeList[index].totalTime.toString() + "  min" : recipeList[index].totalTime.toString() + "  mins") :
                                  ((recipeList[index].totalTime / 60).abs() == 1.0 ? (recipeList[index].totalTime / 60).abs().toString() + "  hr" : (recipeList[index].totalTime / 60).abs().toString() + "  hrs"),
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
                              child: Text(recipeList[index].servings <= 1 ?
                              recipeList[index].servings.toString() + " person" :
                              recipeList[index].servings.toString() + " persons",
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
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  void showFailedToLoadDataView() {

    setState(() {

      _widgetBody = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 20),
              child: Text("Couldn\'t load data",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 2.8 * SizeConfig.textSizeMultiplier,
                ),
              ),
            ),
          ),

          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.all(5),
                  icon: Icon(
                    Icons.refresh,
                    size: 9 * SizeConfig.imageSizeMultiplier,
                    color: Colors.grey,
                  ),
                  onPressed: () {

                    _presenter.getAllRecipe(_context);
                  },
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  void dispose() {

    super.dispose();
    CheckConnectivity().stopChecking();
  }
}