import 'package:cooking_recipe/resources/strings.dart';
import 'package:cooking_recipe/utils/size_config.dart';
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(),
    );
  }
}
