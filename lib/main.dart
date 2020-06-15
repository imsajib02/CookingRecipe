import 'package:cooking_recipe/resources/strings.dart';
import 'package:cooking_recipe/utils/size_config.dart';
import 'package:cooking_recipe/utils/bounce_animation.dart';
import 'package:cooking_recipe/resources/images.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints) {

          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);

              return MaterialApp(
                title: Strings.appName,
                debugShowCheckedModeBanner: false,
                home: MyHomePage(),
              );
            },
          );
        }
    );
  }

}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool passwordVisible = true;
  IconData icon = Icons.visibility;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.loginBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  child: Text(Strings.welcomeNote,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 4.5 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5, bottom: 40),
                  padding: EdgeInsets.all(15),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Flexible(
                            child: Container(
                              height: 6.25 * SizeConfig.heightSizeMultiplier,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                          Flexible(
                            child: Container(
                              height: 8.75 * SizeConfig.heightSizeMultiplier,
                              child: TextField(
                                obscureText: passwordVisible,
                                keyboardType: TextInputType.text,
                                maxLength: 15,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(icon),
                                    onTap: () {

                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                        passwordVisible ? icon = Icons.visibility : icon = Icons.visibility_off;
                                      });
                                    },
                                  ),
                                  labelText: "Password",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                          Flexible(
                            child: BounceAnimation(
                              childWidget: Container(
                                width: 77 * SizeConfig.widthSizeMultiplier,
                                child: RaisedButton(
                                  padding: EdgeInsets.all(10),
                                  elevation: 5,
                                  onPressed: () {

                                    BounceState.scaleAnimationController.forward();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5),
                                  ),
                                  color: Colors.lightBlueAccent,
                                  textColor: Colors.white,
                                  child: Text("LOGIN", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.25 * SizeConfig.textSizeMultiplier,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
