import 'package:flutter/material.dart';
import 'package:markets/src/controllers/home_controller.dart';
import 'package:markets/src/controllers/user_controller.dart';
import 'package:markets/src/elements/SplashSlider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/splash_screen_controller.dart';
import '../helpers/app_config.dart' as config;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;
//  UserController _conn;

  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    _con.progress.addListener(() {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
      });
      if (progress == 100) {
        try {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            //  SplashSliderWidget(),
              Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(70),
                decoration: BoxDecoration(color: Colors.transparent),
                child:  SplashSliderWidget(slides: _con.slides),
              ),
              // Image.asset(
              //   'assets/img/logo.png',
              //   width: 150,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(
                height: config.App(context).appHeight(20),),
              Align(
                alignment: Alignment.bottomCenter,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   width: config.App(context).appWidth(10),
                    //
                    // ),
                    // MaterialButton(
                    //   elevation: 0,
                    //   onPressed: () {
                    //     //Navigator.of(context).pushReplacementNamed('/SignUp');
                    //   },
                    //   textColor:  Colors.grey,
                    //   child:
                    // ),
                    SizedBox(
                      width: 32,
                    ),
                    Text(
                      "Already using Gourmet?",
                      style: TextStyle(color: Colors.grey),
                      //  S.of(context).i_dont_have_an_account
                    ),
                    MaterialButton(
                      padding: EdgeInsets.only(right: 32),
                      elevation: 0,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/Login');
                      },
                      textColor: Theme.of(context).accentColor,
                      child: Text(
                        "Sign In",

                        //  S.of(context).i_dont_have_an_account
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            //  SizedBox(height: 50),
              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
