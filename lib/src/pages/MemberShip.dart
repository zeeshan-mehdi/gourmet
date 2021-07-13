import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/restaurent_app/src/models/route_argument.dart';
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

class RestaurantsMemberShip extends StatefulWidget {
  @override
  _RestaurantsMemberShipState createState() => _RestaurantsMemberShipState();
}

class _RestaurantsMemberShipState extends StateMVC<RestaurantsMemberShip> {
  UserController _con;

  int currentExpiry = 0;

  int purchased = 0;

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

    if(userRepo.currentUser.value!=null && userRepo.currentUser.value.trialEnds!=null && userRepo.currentUser.value.trialEnds!="") {
      DateTime date = DateTime.parse(userRepo.currentUser.value.trialEnds);
      currentExpiry = date
          .difference(DateTime.now())
          .inDays;

      print('current days to expire $currentExpiry');
    }

    if(userRepo.currentUser.value.membershipType !=null ){
      if(userRepo.currentUser.value.membershipType=='Monthly')
        purchased = 1;
      else if(userRepo.currentUser.value.membershipType=='3 Months'){
        purchased = 2;
      }if(userRepo.currentUser.value.membershipType=='6 Months'){
        purchased = 3;
      }if(userRepo.currentUser.value.membershipType=='Yearly'){
        purchased = 2;
      }
    }


    return WillPopScope(
      // onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
          title: Text('Membership',style: Theme.of(context).textTheme.headline3.merge(TextStyle(letterSpacing: 1.3),),),
          leading: IconButton(
            onPressed: () {
                Navigator.of(context).pushReplacementNamed('/Pages', arguments: 3);
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).hintColor,
          ),
        ),
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
            //   alignment: AlignmentDirectional.topCenter,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: config.App(context).appHeight(1),),
              Container(
                width: config.App(context).appWidth(88),
                height: config.App(context).appHeight(23),
                child: Container(
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF3366FF),
                        const Color(0xFF00CCFF),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                 // color: Colors.pink,
               //   elevation: 10,
                  child: Column(
                  //  mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                       ListTile(
                        leading: Icon(Icons.card_membership_outlined, size: 40,color:  Colors.white,),
                        title: Text('${userRepo.currentUser.value.name.toString()}',
                            style: TextStyle(color: Colors.white)),
                         subtitle: //Text("${userRepo.currentUser.value.memebership == 1 ? "is paid user": "not paid"}"),
                        Text("Package is: ${userRepo.currentUser.value.memebership == 1 ? userRepo.currentUser.value.membershipType==null?'Paid Membership':userRepo.currentUser.value.membershipType: "Free Membership"}", style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 60,),
                      Padding(padding: EdgeInsets.only(left: 22.0),
                      child:  Row(
                        children: [
                          Text("Membership will Expire on : ${userRepo.currentUser.value.memebership == 1 ? "${userRepo.currentUser.value.trialEnds?.substring(0,19)??""}": " N/A"}",style: TextStyle(color: Colors.white)),
                          Spacer()

                        ],
                      )),
                      // ButtonTheme.bar(
                      //   child: ButtonBar(
                      //     children: <Widget>[
                      //       FlatButton(
                      //         child: const Text('Edit', style: TextStyle(color: Colors.white)),
                      //         onPressed: () {},
                      //       ),
                      //       FlatButton(
                      //         child: const Text('Delete', style: TextStyle(color: Colors.white)),
                      //         onPressed: () {},
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              // Container(
              //   width: config.App(context).appWidth(100),
              //   height: config.App(context).appHeight(40),
              //   decoration: BoxDecoration(color: Colors.transparent),
              //   child: LoginSliderWidget(slides: _con.slides),
              //   // ),
              // ),
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
                            height: config.App(context).appHeight(53),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            padding: EdgeInsets.only(left:5,right: 5),
                            // padding: EdgeInsets.only(
                            //     top: 8, right: 27, left: 27, bottom: 20),
                            width: config.App(context).appWidth(100),
//              height: config.App(context).appHeight(55),

                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Membership Plans",
                                  //  "${userRepo.currentUser.value.trialEnds.toString()}",
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

                                  SizedBox(height: 5,),

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
                                                "Membership For 1 month Plan \n KWD 10.00",
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
                                                  purchased==1 ? "Purchased" :"Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: purchased==1 ? Theme.of(context).focusColor: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () async {
                                                  if(purchased!=1)
                                                    await _con.updateMembership(userRepo.currentUser.value,settingRepo.setting.value.mobileLanguage.value.languageCode, context,10.0,currentExpiry+30,'Monthly');
                                                  else
                                                    Fluttertoast.showToast(msg: 'Already Purchased');
                                                  //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>PagesTestWidget(currentTab: 5,)));
                                                //  _con.login();
                                                },
                                              ),
                                            )
                                            // Container(
                                            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                            //   decoration: BoxDecoration(
                                            //     color: Theme.of(context).primaryColor,
                                            //     borderRadius: BorderRadius.circular(6),
                                            //     boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)],
                                            //   ),
                                            //   child: ListView(
                                            //     shrinkWrap: true,
                                            //     primary: false,
                                            //     children: <Widget>[
                                            //        ButtonTheme(
                                            //           padding: EdgeInsets.all(0),
                                            //           minWidth: 50.0,
                                            //           height: 25.0,
                                            //           child: PaymentSettingsDialog(
                                            //             creditCard: _con.creditCard,
                                            //             onChanged: () {
                                            //               _con.updateCreditCard(_con.creditCard);
                                            //               //setState(() {});
                                            //             },
                                            //           ),
                                            //         ),
                                            //       //),
                                            //
                                            //     ],
                                            //   ),
                                            // ),
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
                                                "Membership For 3 month Plan \n KWD 25.00",
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
                                                  purchased==2 ? "Purchased" :"Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: purchased==2 ? Theme.of(context).focusColor :Theme.of(context)
                                                    .accentColor,
                                                onPressed: () async {
                                                  if(purchased!=2) {
                                                    await _con.updateMembership(
                                                        userRepo.currentUser
                                                            .value,
                                                        settingRepo.setting
                                                            .value
                                                            .mobileLanguage
                                                            .value.languageCode,
                                                        context, 25.0,
                                                        currentExpiry + 90,
                                                        '3 Months');
                                                  }else{
                                                    Fluttertoast.showToast(msg: 'Already Purchased');
                                                    // _con.login();
                                                  }
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
                                                "Membership For 6 month Plan \n KWD 50.00",
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
                                                  purchased==3?'Purchased':"Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: purchased==3 ? Theme.of(context).focusColor : Theme.of(context)
                                                    .accentColor,
                                                onPressed: () async {

                                                  if(purchased!=3) {
                                                    await _con.updateMembership(
                                                        userRepo.currentUser
                                                            .value,
                                                        settingRepo.setting
                                                            .value
                                                            .mobileLanguage
                                                            .value.languageCode,
                                                        context, 50.0,
                                                        currentExpiry + 182,
                                                        '6 Months');
                                                  }else{
                                                    Fluttertoast.showToast(msg: 'Already Purchased');
                                                  }
                                                  // _con.login();
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
                                                "Membership For 1 year Plan \n KWD 80.00",
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
                                                  purchased==4? "Purchased" : "Purchase",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () async {
                                                  if(purchased!=4) {
                                                    await _con.updateMembership(
                                                        userRepo.currentUser
                                                            .value,
                                                        settingRepo.setting
                                                            .value
                                                            .mobileLanguage
                                                            .value.languageCode,
                                                        context, 80.0,
                                                        currentExpiry + 365,
                                                        'Yearly');
                                                  }else{
                                                    Fluttertoast.showToast(msg: 'Already Purchased');
                                                  }
                                                  // _con.login();
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
            ]
        ),
      ),
    );
  }
}
