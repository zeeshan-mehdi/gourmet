import 'package:flutter/material.dart';
import 'package:markets/src/elements/LoginSlider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget>{
  UserController _con;


  _LoginWidgetState() : super(UserController()) {
    _con = controller;

  }
  // _LoginWidgetState() : super(UserController()) {
  //   _con = controller;
  // }
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
  }
 // HomeController _conn;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(40),
                decoration: BoxDecoration(color: Colors.transparent),
                child:  LoginSliderWidget(slides: _con.slides),
              ),
            ),
            // Positioned(
            //   top: config.App(context).appHeight(37) - 120,
            //   child: Container(
            //     width: config.App(context).appWidth(84),
            //     height: config.App(context).appHeight(37),
            //     child: Text(
            //       S.of(context).lets_start_with_login,
            //       style: Theme.of(context).textTheme.headline2.merge(TextStyle(color: Theme.of(context).primaryColor)),
            //     ),
            //   ),
            // ),

            Positioned(
              top: config.App(context).appHeight(33) - 0,
              child: Column(
                children: [
                  Container(
                    height: config.App(context).appHeight(70),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 50,
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            //  col
                          )
                        ]),
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: EdgeInsets.only(
                        top: 25, right: 27, left: 27, bottom: 20),
                    width: config.App(context).appWidth(100),
//              height: config.App(context).appHeight(55),
                    child: Form(
                      key: _con.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            S.of(context).welcome + " " + "BACK!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1.merge(
                              TextStyle(
                                //color: Theme.of(context).buttonColor)
                                  color: Colors.black),
                            ),
                          ),
                          Text(
                            "Login to your account",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(
                                //color: Theme.of(context).primaryColor)),
                                  color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                              //  border: Border(),
                              // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input) => _con.user.email = input,
                              validator: (input) => !input.contains('@')
                                  ? S.of(context).should_be_a_valid_email
                                  : null,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                // labelText: S.of(context).email,
                                labelStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(
                                    left: 12, right: 12, top: 6, bottom: 6),

                                hintText: 'johndoe@gmail.com',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                //  prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                                border: InputBorder.none,
                                //  border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,),borderRadius: BorderRadius.all(Radius.circular(40))),
                                //  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              ),
                            ),
                          ),
                          //
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                              //  border: Border(),
                              // border:  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2),),)),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (input) => _con.user.password = input,
                              validator: (input) => input.length < 3
                                  ? S
                                  .of(context)
                                  .should_be_more_than_3_characters
                                  : null,
                              obscureText: _con.hidePassword,
                              decoration: InputDecoration(
                                fillColor: Colors.grey,
                                // labelText: S.of(context).email,
                                labelStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.only(
                                    left: 12, right: 12, top: 12, bottom: 6),
                                hintText: '••••••••••••',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                //  prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _con.hidePassword = !_con.hidePassword;
                                    });
                                  },
                                  color: Theme.of(context).focusColor,
                                  icon: Icon(_con.hidePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                ),
                                border: InputBorder.none,

                                // border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent,),
                                //     borderRadius: BorderRadius.all(Radius.circular(40))),
                                //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          BlockButtonWidget(
                            text: Text(
                              S.of(context).login,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              _con.login();
                            },
                          ),
                          SizedBox(height: 15),
                          // MaterialButton(
                          //   elevation: 0,
                          //   onPressed: () {
                          //     Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
                          //   },
                          //   shape: StadiumBorder(),
                          //   textColor: Theme.of(context).hintColor,
                          //   child: Text(S.of(context).skip),
                          //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                          // ),

                          MaterialButton(
                            elevation: 0,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/ForgetPassword');
                            },
                            textColor: Theme.of(context).hintColor,
                            child: Text(
                              //  S.of(context).i_forgot_password
                                "Forgot your password?"),
                          ),
                          Container(
                            //width: config.App(context).appWidth(30) -100,
                            // padding: EdgeInsets.only(left: 20,right: 20),
                            // color: Colors.black,
                            child: Row(
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
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.grey),
                                  //  S.of(context).i_dont_have_an_account
                                ),
                                MaterialButton(
                                  padding: EdgeInsets.only(right: 32),
                                  elevation: 0,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/SignUp');
                                  },
                                  textColor: Theme.of(context).accentColor,
                                  child: Text(
                                    "Sign up",

                                    //  S.of(context).i_dont_have_an_account
                                  ),
                                ),
                                // Spacer(),
                              ],
                            ),
                          ),

                          SizedBox(height: 30),
//                      SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: 10,
            //   child: Column(
            //     children: <Widget>[
            //       MaterialButton(
            //         elevation: 0,
            //         onPressed: () {
            //           Navigator.of(context).pushReplacementNamed('/ForgetPassword');
            //         },
            //         textColor: Theme.of(context).hintColor,
            //         child: Text(S.of(context).i_forgot_password),
            //       ),
            //       MaterialButton(
            //         elevation: 0,
            //         onPressed: () {
            //           Navigator.of(context).pushReplacementNamed('/SignUp');
            //         },
            //         textColor: Theme.of(context).hintColor,
            //         child: Text(S.of(context).i_dont_have_an_account),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
