import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/elements/CardWidget.dart';
import 'package:markets/restaurent_app/src/pages/pages.dart';
import 'package:markets/src/elements/LoginSlider.dart';
import 'package:markets/src/elements/PaymentSettingsDialog.dart';
import 'package:markets/src/elements/ProfileKitchenSection.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../models/user.dart' as userModel;

import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;
import '../repository/settings_repository.dart' as settingRepo;

class Coisines extends StatefulWidget {
  @override
  _CoisinesState createState() => _CoisinesState();
}

class _CoisinesState extends StateMVC<Coisines> {
  UserController _con;

  _CoisinesState() : super(UserController()) {
    _con = controller;
  }

  List<Cuisines> cuisinesItems;

  // _CoisinesState() : super(UserController()) {
  //   _con = controller;
  // }
  @override
  void initState() {
    super.initState();
    cuisinesItems = Cuisines.sampleData();
  }

  // HomeController _conn;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Cuisines",
                style: TextStyle(
                  color: Colors.black,
                )),
            leading: InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            )),
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Column(
            //   alignment: AlignmentDirectional.topCenter,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: config.App(context).appHeight(2),
              ),
              Container(
                child: new SingleChildScrollView(
                  child: new Column(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                            // transform:  Matrix4.translationValues(
                            //     0.0, -12.0, 0.0),
                            height: config.App(context).appHeight(84),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              //  borderRadius:
                              //  BorderRadius.all(Radius.circular(20)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     blurRadius: 50,
                              //     color: Theme.of(context)
                              //         .hintColor
                              //         .withOpacity(0.2),
                              //     //  col
                              //   )
                              // ]
                            ),
                            // margin: EdgeInsets.symmetric(
                            //   horizontal: 20,
                            // ),
                            padding: EdgeInsets.only(
                                top: 8, right: 27, left: 27, bottom: 20),
                            width: config.App(context).appWidth(100),
//                          height: config.App(context).appHeight(55),

                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: config.App(context).appHeight(80),
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: cuisinesItems.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            print("hello");
                                            //  },
                                            Navigator.of(context).pushNamed(
                                              '/CoisinesDetail',
                                            );
                                          },
                                          child: Container(
                                            width: 292,
                                            height: 200,
                                            margin: EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                top: 8,
                                                bottom: 8),
                                            decoration: BoxDecoration(
                                              // color: Colors.grey.withOpacity(0.9),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.grey,
                                                  Colors.grey.withOpacity(0.9),
                                                ],
                                                begin: const FractionalOffset(
                                                    1.0, 1.0),
                                                end: const FractionalOffset(
                                                    1.0, 0.0),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                // Image of the card
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    // mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                      Spacer(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          Text(
                                                            cuisinesItems[index]
                                                                .name,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            softWrap: false,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 22),
                                                          ),
                                                          Text(
                                                            "${cuisinesItems.length} Restaurants",
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontSize: 18),
                                                          ),
                                                          SizedBox(height: 5),
                                                          // Row(
                                                          //   children: Helper.getStarsList(double.parse(market.rate)),
                                                          // ),
                                                        ],

                                                        ///   ),
                                                      ),
                                                      Spacer(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
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

                                  //   SizedBox(height: 30),
                                  //   SizedBox(height: 10),
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

class Cuisines {
  int id;
  String name;

  Cuisines({this.id, this.name});

  static List<Cuisines> sampleData() {
    return [
      Cuisines(id: 1, name: "Asian"),
      Cuisines(id: 2, name: "Middle Eastern"),
      Cuisines(id: 3, name: "Desert"),
      Cuisines(id: 4, name: "chinese")
    ];
  }
}
