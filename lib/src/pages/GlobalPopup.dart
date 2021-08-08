import 'dart:convert';
//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:markets/src/elements/BlockButtonWidget.dart';
import 'dart:convert' as convert;
import '../helpers/app_config.dart' as config;

class Constants {
  Constants._();

  static const double padding = 12;
  static const double avatarRadius = 20;
}

class GlobalPopup extends StatefulWidget {
  final String title, subTitle, imageName,btnTitle ,bottombtnTitle;
  final PopupType popupType;
  final Function onEnablePressed;

  GlobalPopup(
      {this.title, this.subTitle, this.imageName, this.popupType,this.btnTitle,this.bottombtnTitle,this.onEnablePressed});

  @override
  _GlobalPopupState createState() => _GlobalPopupState(
    title: title,
    subTitle: subTitle,
    imageName: imageName,
    popupType: popupType,
    btnTitle: btnTitle,
    bottombtnTitle: bottombtnTitle,
    onEnablePressed: onEnablePressed

  );
}

class _GlobalPopupState extends State<GlobalPopup> {
  final String title, subTitle, imageName, btnTitle, bottombtnTitle;
  final PopupType popupType;
  final Function onEnablePressed;
  _GlobalPopupState(
      {this.title, this.subTitle, this.imageName, this.popupType,this.btnTitle,this.bottombtnTitle,this.onEnablePressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: config.App(context).appHeight(100),
      width: config.App(context).appWidth(100),
      // width: ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: new Icon(Icons.arrow_back,
                  color: Theme.of(context).hintColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Spacer(),
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),

                  width: config.App(context).appWidth(80),
                  height: config.App(context).appHeight(60),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                        ),
                      ]),
                  child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: <Widget>[
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //   height: config.App(context).appHeight(4.5),
                      //   width: config.App(context).appWidth(88),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Spacer(),
                      //       // Container(
                      //       //   // alignment: Alignment.topRight,
                      //       //   child: Material(
                      //       //       child: InkWell(
                      //       //         onTap: () {
                      //       //           print("onclosses");
                      //       //           Navigator.of(context).pop();
                      //       //         },
                      //       //         child: Container(
                      //       //           margin: EdgeInsets.all(6),
                      //       //           height: 14,
                      //       //           width: 12,
                      //       //           child: ClipRRect(
                      //       //               borderRadius: BorderRadius.circular(0.0),
                      //       //               child: Image(
                      //       //                 image: AssetImage(
                      //       //                   ('assets/img/CrossIcon.png'),
                      //       //                 ),
                      //       //               )),
                      //       //         ),
                      //       //       )),
                      //       //
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 42,),
                      Container(
                        transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                        margin: EdgeInsets.fromLTRB(0, 4, 2, 0),
                        //height: Responsive.height(2.5, context),
                        width: config.App(context).appWidth(80),
                        height: config.App(context).appHeight(16),
                        //  width: Responsive.width(88, context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Image(
                                image: AssetImage(
                                    'assets/img/$imageName'),
                                fit: BoxFit.cover),
                            //  Text(title ,maxLines: 3,),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text(
                        title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold

                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        subTitle,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300

                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 30,right: 30),
                        child:   BlockButtonWidget(

                          text: Text(
                            "$btnTitle",
                            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16,),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: ()  {

                            switch (popupType){
                              case PopupType.forgotPassword:
                                print("forgot password");
                                Navigator.of(context).pushReplacementNamed('/LoginOption');
                                break;
                              case PopupType.enableLocation:
                                print("enableLocation");
                                Navigator.of(context).pop();
                                this.onEnablePressed();
                                break;
                              case PopupType.orderSucessfull:
                                Navigator.of(context).pushNamed('/Pages',arguments: 1);
                                print("orderSucessfull");
                                break;
                              case PopupType.orderFailed:
                              //Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/Pages',arguments: 0);
                                print("orderfailed");
                                break;
                            }
                            // _con.login();
                            //SharedPreferences prefs = await SharedPreferences.getInstance();
                            // int counter = (prefs.getInt('counter') ?? 0) + 1;
                            // print('set boolean true.');
                            //  await prefs.setBool('welcome', true);

                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child:  InkWell(
                          child: Text(
                            "$bottombtnTitle",
                            style: TextStyle(color: Colors.grey,fontSize: 14,),
                          ),
                          //  color: Theme.of(context).accentColor,
                          onTap: ()  {

                            switch (popupType){
                              case PopupType.forgotPassword:
                                print("forgot password");
                                Navigator.of(context).pushReplacementNamed('/LoginOption');
                                break;
                              case PopupType.enableLocation:
                                print("enableLocation");

                                break;
                              case PopupType.orderSucessfull:
                                //Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/Pages',arguments: 1);
                                print("orderSucessfull");
                                break;
                              case PopupType.orderFailed:
                              //Navigator.of(context).pop();
                                Navigator.of(context).pushNamed('/Pages',arguments: 0);
                                print("orderfailed");
                                break;
                            }



                            // _con.login();
                            //SharedPreferences prefs = await SharedPreferences.getInstance();
                            // int counter = (prefs.getInt('counter') ?? 0) + 1;
                            // print('set boolean true.');
                            //  await prefs.setBool('welcome', true);
                          //  Navigator.of(context).pushReplacementNamed('/Login');
                          },
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Spacer()
        ],
      ),
    );
  }
}

enum PopupType { forgotPassword, enableLocation, orderSucessfull,orderFailed }
