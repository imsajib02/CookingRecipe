import 'package:cooking_recipe/network/retrofit/retrofitinstance.dart';
import 'package:cooking_recipe/resources/strings.dart';
import 'package:cooking_recipe/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:cooking_recipe/view/login_view.dart';

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
                home: LoginView(),
              );
            },
          );
        }
    );
  }

}
