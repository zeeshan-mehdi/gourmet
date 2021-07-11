import 'package:cached_network_image/cached_network_image.dart';
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

class CoisinesDetail extends StatefulWidget {
  @override
  _CoisinesDetailState createState() => _CoisinesDetailState();
}

class _CoisinesDetailState extends StateMVC<CoisinesDetail> {
  UserController _con;

  _CoisinesDetailState() : super(UserController()) {
    _con = controller;
  }

  List<CuisinesDetail> cuisinesDetailItems;

  @override
  void initState() {
    super.initState();
    cuisinesDetailItems = CuisinesDetail.sampleData();
  }

  // HomeController _conn;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //     title: Text("Cuisines",
        //         style: TextStyle(
        //           color: Colors.black,
        //         )),
        //     leading: InkWell(
        //       child: Icon(
        //         Icons.arrow_back,
        //         color: Colors.black,
        //       ),
        //       onTap: () {
        //         Navigator.of(context).pop();
        //       },
        //     )),
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Column(
            // alignment: AlignmentDirectional.topCenter,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: config.App(context).appHeight(4),),
              Container(
                  child: new Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: config.App(context).appWidth(100),
                            height: config.App(context).appHeight(34),
                            decoration: BoxDecoration(color: Colors.transparent),
                            child: LoginSliderWidget(slides: _con.slides),
                            // ),
                          ),
                         Container(
                           margin: EdgeInsets.only(left: 12,top: 6),
                           child: Row(
                             children: [
                               InkWell(
                                 child: Icon(
                                   Icons.arrow_back,
                                   color: Colors.black,
                                 ),
                                 onTap: () {
                                   Navigator.of(context).pop();
                                 },
                               ),
                               Spacer()
                             ],
                           )
                         )
                        ],
                      ),

                      Container(
                          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                          margin: EdgeInsets.only(left: 34),
                          child: Row(
                            children: [
                           //   Spacer(),
                              Text(
                                "4 kitchen",
                                style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              Spacer()
                            ],
                          )),
                      Container(
                          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                          height: config.App(context).appHeight(59),
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
                              top: 0, right: 20, left: 20, bottom: 0),
                          width: config.App(context).appWidth(100),
//                          height: config.App(context).appHeight(55),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: config.App(context).appHeight(59),
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: cuisinesDetailItems.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          print("hello");
                                          //  },

                                          // Navigator.of(context).pushNamed('/Product',
                                          //     arguments: RouteArgument(
                                          //       id: '0',
                                          //       param: widget.marketsList.elementAt(index).id,
                                          //       heroTag: widget.heroTag,
                                          //     ));
                                        },
                                        child: Container(
                                          width: 292,
                                          height: 130,
                                          margin: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 8,
                                              bottom: 8),
                                          decoration: BoxDecoration(
                                            // color: Colors.grey.withOpacity(0.9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.white,
                                             boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.08),
                                                //  col
                                              )
                                            ]
                                            // gradient: LinearGradient(
                                            //   colors: [
                                            //     Colors.grey,
                                            //     Colors.grey.withOpacity(0.9),
                                            //   ],
                                            //   begin: const FractionalOffset(
                                            //       1.0, 1.0),
                                            //   end: const FractionalOffset(
                                            //       1.0, 0.0),
                                            //   stops: [0.0, 1.0],
                                            //   tileMode: TileMode.clamp,
                                            // ),
                                          ),
                                          child:  Column(
                                            children: [
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                // mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  // Image of the card
                                                  SizedBox(height: 20,),
                                                  Container(
                                                   //  tag: this.heroTag + market.id,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                                      child: CachedNetworkImage(
                                                        height: 60,
                                                        width: 80,
                                                        fit: BoxFit.cover,
                                                        imageUrl: "market.image.url",
                                                        placeholder: (context, url) => Image.asset(
                                                          'assets/img/loading.gif',
                                                          fit: BoxFit.cover,
                                                          width: double.infinity,
                                                          height: 60,
                                                        ),
                                                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          cuisinesDetailItems[index].name,
                                                          overflow: TextOverflow.fade,
                                                          softWrap: false,
                                                          style: Theme.of(context).textTheme.subtitle1,
                                                        ),
                                                        Text(
                                                          cuisinesDetailItems[index].address,
                                                         // cuisinesDetailItems.name.length > 25 ? cuisinesDetailItems.name.substring(0,25)+'...' : market?.address,
                                                          // Helper.skipHtml(market?.address??''),
                                                          overflow: TextOverflow.ellipsis,

                                                          //overflow: TextOverflow.fade,
                                                          softWrap: false,
                                                          style: Theme.of(context).textTheme.caption,
                                                        ),
                                                      //  SizedBox(height: 5),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          children: Helper.getStarsList(double.parse(cuisinesDetailItems[index].rating)),
                                                        ),
                                                        // Row(
                                                        //   children: Helper.getStarsList(double.parse(market.rate)),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  // )
                                                ],
                                              ),
                                              Spacer(),
                                             // SizedBox(height: 12,),
                                              // Divider(color: Colors.black.withOpacity(0.2),
                                              //   indent: 0,endIndent: 0,)
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
                          ),
                    ],
                  ),
              ),
            ]),
      ),
    );
  }
}

// class Cuisines {
//   int id;
//   String name;
//   Cuisines({this.id, this.name});
//   static List<Cuisines> sampleData() {
//     return [
//       Cuisines(id: 1, name: "Asian"),
//       Cuisines(id: 2, name: "Middle Eastern"),
//       Cuisines(id: 3, name: "Desert"),
//       Cuisines(id: 4, name: "chinese")
//     ];
//   }
// }


class CuisinesDetail {
  int id;
  String name;
  String address;
  String rating;

  CuisinesDetail({this.id, this.name,this.address,this.rating});
  static List<CuisinesDetail> sampleData() {
    return [
      CuisinesDetail(id: 1, name: "Kichen One",address: "Islamabad, Pakistan",rating: "2.0"),
      CuisinesDetail(id: 2, name: "Kichen Two",address: "Karachi, Pakistan",rating: "4.0"),
      CuisinesDetail(id: 3, name: "Kichen Three",address: "Hyderabad, Pakistan",rating: "3.0"),
      CuisinesDetail(id: 4, name: "Kichen Four",address: "Islamabad, Pakistan",rating: "5.0"),
    ];
  }
}
