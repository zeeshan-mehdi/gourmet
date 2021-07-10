import 'package:flutter/material.dart';
import 'package:markets/src/elements/LoginSlider.dart';
import 'package:markets/src/elements/ProfileKitchenSection.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;

class RestaurantsMemberShip extends StatefulWidget {
  @override
  _RestaurantsMemberShipState createState() => _RestaurantsMemberShipState();
}

class _RestaurantsMemberShipState extends StateMVC<RestaurantsMemberShip> {
  UserController _con;

  _RestaurantsMemberShipState() : super(UserController()) {
    _con = controller;
  }

  // _RestaurantsMemberShipState() : super(UserController()) {
  //   _con = controller;
  // }
  @override
  void initState() {
    super.initState();
  }

  // HomeController _conn;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Column(
            //   alignment: AlignmentDirectional.topCenter,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(40),
                decoration: BoxDecoration(color: Colors.transparent),
                child: LoginSliderWidget(slides: _con.slides),
                // ),
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
              Container(
                child: new SingleChildScrollView(
                  child: new Column(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                            transform:  Matrix4.translationValues(
                                0.0, -12.0, 0.0),
                            height: config.App(context).appHeight(60),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 50,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2),
                                    //  col
                                  )
                                ]),
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            padding: EdgeInsets.only(
                                top: 8, right: 27, left: 27, bottom: 20),

                            width: config.App(context).appWidth(100),
//              height: config.App(context).appHeight(55),

                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Membership Plans",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .merge(
                                          TextStyle(
                                              //color: Theme.of(context).buttonColor)
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            config.App(context).appWidth(100),
                                        height:
                                            config.App(context).appHeight(16),
                                        margin:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                        //  color: Colors.grey,
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent
                                              .withOpacity(0.3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                                offset: Offset(0, 2)),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  IconButton(
                                                    icon: new Icon(
                                                        Icons
                                                            .card_giftcard_outlined,
                                                        color: Theme.of(context)
                                                            .hintColor),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, -10.0, 0.0),
                                              child: Text(
                                                "Membership For 1 month Plan \n \$10.00",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, 12.0, 0.0),
                                              height: 30,
                                              width: 100,
                                              child: BlockButtonWidget(
                                                text: Text(
                                                  "Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () {
                                                  _con.login();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            config.App(context).appWidth(100),
                                        height:
                                            config.App(context).appHeight(16),
                                        margin:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                        //  color: Colors.grey,
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent
                                              .withOpacity(0.25),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                                offset: Offset(0, 2)),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  IconButton(
                                                    icon: new Icon(
                                                        Icons
                                                            .card_giftcard_outlined,
                                                        color: Theme.of(context)
                                                            .hintColor),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, -10.0, 0.0),
                                              child: Text(
                                                "Membership For 3 month Plan \n \$25.00",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, 12.0, 0.0),
                                              height: 30,
                                              width: 100,
                                              child: BlockButtonWidget(
                                                text: Text(
                                                  "Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () {
                                                  _con.login();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            config.App(context).appWidth(100),
                                        height:
                                            config.App(context).appHeight(16),
                                        margin:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                        //  color: Colors.grey,
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurpleAccent
                                              .withOpacity(0.09),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                                offset: Offset(0, 2)),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  IconButton(
                                                    icon: new Icon(
                                                        Icons
                                                            .card_giftcard_outlined,
                                                        color: Theme.of(context)
                                                            .hintColor),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, -10.0, 0.0),
                                              child: Text(
                                                "Membership For 6 month Plan \n \$50.00",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, 12.0, 0.0),
                                              height: 30,
                                              width: 100,
                                              child: BlockButtonWidget(
                                                text: Text(
                                                  "Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () {
                                                  _con.login();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            config.App(context).appWidth(100),
                                        height:
                                            config.App(context).appHeight(16),
                                        margin:
                                            EdgeInsets.only(top: 6, bottom: 6),
                                        //  color: Colors.grey,
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent
                                              .withOpacity(0.3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                                offset: Offset(0, 2)),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Spacer(),
                                                  IconButton(
                                                    icon: new Icon(
                                                        Icons
                                                            .card_giftcard_outlined,
                                                        color: Theme.of(context)
                                                            .hintColor),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, -10.0, 0.0),
                                              child: Text(
                                                "Membership For 1 year Plan \n \$80.00",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      12.0, 12.0, 0.0),
                                              height: 30,
                                              width: 100,
                                              child: BlockButtonWidget(
                                                text: Text(
                                                  "Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () {
                                                  _con.login();
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // BlockButtonWidget(
                                  //   text: Text(
                                  //     S.of(context).login,
                                  //     style: TextStyle(
                                  //         color:
                                  //             Theme.of(context).primaryColor),
                                  //   ),
                                  //   color: Theme.of(context).accentColor,
                                  //   onPressed: () {
                                  //     _con.login();
                                  //   },
                                  // ),

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

                                  SizedBox(height: 30),
//                      SizedBox(height: 10),
                                ],
                                //),
                              ),
                            )),
                      ),
                    ],
                  ),
                  //  ),

                  //  ),
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
                ),
              ),
            ]),
      ),
    );
  }
}
