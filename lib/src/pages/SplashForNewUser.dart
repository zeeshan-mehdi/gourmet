import 'package:flutter/material.dart';
import '../controllers/splash_screen_controller.dart';
import 'package:markets/src/controllers/home_controller.dart';
import 'package:markets/src/controllers/user_controller.dart';
import 'package:markets/src/elements/CircularLoadingWidget.dart';
import 'package:markets/src/elements/SplashSlider.dart';
import 'package:markets/src/pages/LoginOption.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/app_config.dart' as config;

class SplashForNewUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashForNewUserScreenState();
  }
}

class SplashForNewUserScreenState extends StateMVC<SplashForNewUserScreen> {
  SplashScreenController _con;
  //  UserController _conn;

  SplashForNewUserScreenState() : super(SplashScreenController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
   // loadData();
  }

  void loadData()  {
    _con.progress.addListener(() async {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
      });
      if (progress == 100) {
        try {
          print("suces");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // print( prefs.get("welcome"));
          prefs.get("welcome");
          if (prefs.get("welcome") == true){
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
          }else{
            Navigator.of(context)
                .pushReplacementNamed('/LoginOption');
          }
          //     .then((value) => setState(() {
          //   isLoggedIn = value;
          // }));
          //check();
        } catch (e) {}
      }
    });
  }
  bool isLoggedIn = false;
  check() async {

    // prefs.getBool("isfirstRun").then((value) =>
    //     setState(() {
    //       isLoggedIn = value;
    //     }));

    FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new LoginOption();
          default:
            if (!snapshot.hasError) {
              // @ToDo("Return a welcome screen")
              return snapshot.data.getBool("welcome") != null
                  ? Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2)
                  : new CircularLoadingWidget();
            } else {
              // return new ErrorScreen(error: snapshot.error);
            }
        }
      },
    );
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
              //  SplashForNewUserSliderWidget(),
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
                      onPressed: () async {
                        // _con.login();
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        // int counter = (prefs.getInt('counter') ?? 0) + 1;
                        print('set boolean true.');
                        await prefs.setBool('welcome', true);
                        Navigator.of(context).pushReplacementNamed('/LoginOption');
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
