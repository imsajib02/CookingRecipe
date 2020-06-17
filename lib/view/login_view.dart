import 'package:cooking_recipe/contract/login_contract.dart';
import 'package:cooking_recipe/model/user_model.dart';
import 'package:cooking_recipe/network/connectivity/connectivity_check.dart';
import 'package:cooking_recipe/presenter/login_presenter.dart';
import 'package:cooking_recipe/resources/images.dart';
import 'package:cooking_recipe/resources/strings.dart';
import 'package:cooking_recipe/utils/bounce_animation.dart';
import 'package:cooking_recipe/utils/size_config.dart';
import 'package:cooking_recipe/utils/variables.dart';
import 'package:cooking_recipe/view/homepage_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';

class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements View{

  Presenter _presenter;
  User user;
  var progressDialog;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool passwordVisible = true;
  IconData icon = Icons.visibility;

  @override
  void initState() {

    super.initState();
    CheckConnectivity().startChecking(context);
    user = User();
    _presenter = LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Builder(
        builder: (BuildContext context) {

          return Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.loginBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Flexible(
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

                  Flexible(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5, bottom: 100),
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
                                    controller: _emailController,
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
                                    controller: _passwordController,
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

                                        user.email = _emailController.text;
                                        user.password = _passwordController.text;

                                        _presenter.validateInput(context, user);
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
          );
        },
      ),
    );
  }

  @override
  void onEmpty(String message) {

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightBlue,
        textColor: Colors.white,
        fontSize: 2.2 * SizeConfig.textSizeMultiplier,
    );
  }

  @override
  void onLoginFailure(BuildContext context, String message) {

    final snackbar = SnackBar(
      content: Text(message, style: TextStyle(fontSize: 1.8 * SizeConfig.textSizeMultiplier, fontWeight: FontWeight.bold),),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    );

    Scaffold.of(context).showSnackBar(snackbar);
  }

  @override
  void onLoginSuccess() {

    stopProgressDialog();

    setState(() {
      _emailController.clear();
      _passwordController.clear();
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageView()));
  }

  @override
  void stopProgressDialog() {

    progressDialog.dismiss();
  }

  @override
  void startProgressDialog(BuildContext context) {

    progressDialog = showProgressDialog(context: context,
      loadingText: "Please wait...",
      radius: 10.0,
      backgroundColor: Colors.black,
    );
  }

  @override
  void dispose() {

    super.dispose();
    CheckConnectivity().stopChecking();

    Variables.isConnected = false;
    Variables.hasInternet = false;
  }
}