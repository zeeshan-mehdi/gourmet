import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:markets/src/elements/CircularLoadingWidget.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markets/generated/l10n.dart';
import 'package:markets/restaurent_app/src/controllers/order_controller.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/controllers/checkout_controller.dart';
import 'package:markets/src/controllers/market_controller.dart';
import 'package:markets/src/controllers/product_controller.dart';
import 'package:markets/src/elements/AddToCartAlertDialog.dart';
import 'package:markets/src/elements/ShoppingCartButtonWidget.dart';
import 'package:markets/src/models/market.dart';
import 'package:markets/src/models/product.dart';
import 'package:markets/src/pages/cart.dart';
import 'package:markets/src/pages/kitchen_cart.dart';
import 'package:markets/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;
import '../repository/settings_repository.dart' as settingRepo;
class MenuGridScreen extends StatefulWidget {
  RouteArgument routeArgument;
   MenuGridScreen({this.routeArgument}) ;

  @override
  _MenuGridScreenState createState() => _MenuGridScreenState();
}

class _MenuGridScreenState extends StateMVC<MenuGridScreen> {
  MarketController _con;

  ProductController _productController;
  CartController _cartController;

  int cartIndex = 0;

  Function refreshCart;
  List<Product> products = List<Product>();
  bool cartLoading = false;
  _MenuGridScreenState() : super(MarketController()) {
    _con = controller;
  }
  void initState() {
    _productController = ProductController();
    _cartController = CartController();

    _productController.listenForCart();
    _con.listenForMarket(id: widget.routeArgument.param).then((value) {
      setState(() {
        _con.market = value as Market;
        print(_con.market.toMap());
      });
    });

    _con.listenForProducts(widget.routeArgument.param);

    // _con.listenForCart();
    // _con.listenForFavorite(productId: widget.routeArgument.id);
    super.initState();
  }
  int selectedIndex = null;
  @override
  Widget build(BuildContext context) {
    String langCode = settingRepo.setting.value.mobileLanguage.value.languageCode;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(height);
    ScreenUtil.init(context,
        width: width, height: height, allowFontScaling: false);
    return Scaffold(
      backgroundColor: Colors.black,
        body: _con.market == null || _con.market?.image == null || _productController.loading
        ? CircularLoadingWidget(height: 500)
        :  RefreshIndicator(
    onRefresh: _con.refreshMarket,
    child: Stack(
        children: [
          Container(
            height: ScreenUtil.screenHeight * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      // color: Colors.greenAccent,
                    ),
                    child: CachedNetworkImage(
                      height: ScreenUtil.screenHeight * 0.4,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: _con.market.image.url,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    )),
                Container(
                  height: ScreenUtil.screenHeight * 0.35,
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      stops: [0.2, 0.99],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      tileMode: TileMode.repeated,
                      // end: const Alignment(0.3, 0.2),
                      // begin: const Alignment(0.5, 0.6),
                      colors: <Color>[
                        Colors.white60.withOpacity(0.3),
                        Colors.black87,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(top: ScreenUtil.screenHeight * 0.1, child: Header()),
//           DraggableScrollableSheet(
//             initialChildSize: 0.67,
//
// // maxChildSize: 1.0,
//             minChildSize: 0.67,
//             builder: (BuildContext context,
//                 ScrollController scrollController) {
//               return Container(
//                 height: ScreenUtil.screenHeight,
//                 width: ScreenUtil.screenWidth,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   padding: EdgeInsets.all(5),
//                   child: IntrinsicHeight(
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                           minHeight:
//                           MediaQuery.of(context).size.height *
//                               1,
//                           maxHeight:
//                           MediaQuery.of(context).size.height *
//                               1),
//                       child: Column(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             height: ScreenUtil().setHeight(20),
//                           ),
//
//                           // SizedBox(
//                           //   height: ScreenUtil().setHeight(5),
//                           // ),
//                           // Container(
//                           //   height: ScreenUtil.screenHeight * 0.22,
//                           //   width: ScreenUtil.screenWidth,
//                           //   child: ListView.builder(
//                           //     scrollDirection: Axis.horizontal,
//                           //     itemCount: _con.products.length,
//                           //     itemBuilder: (context, i) {
//                           //       return InkWell(
//                           //         onTap: () {
//                           //
//                           //           setState(() {
//                           //             cartLoading = true;
//                           //           });
//                           //
//                           //           // if (!isPresent) {
//                           //           print(_con.products[i].name);
//                           //           setState(() {
//                           //             selectedIndex = i;
//                           //             //  List<Product> products = List<Product>();
//                           //             products.add(_con.products[i]);
//                           //             // products.add(SelectedOrderItem(id: _con.products[index].id,name:  _con.products[index].name,imageUrl:  _con.products[index].image.url,price:_con.products[index].price ));
//                           //             products.toSet().toList();
//                           //
//                           //             print('index  $i');
//                           //
//                           //             if (currentUser
//                           //                 .value.apiToken ==
//                           //                 null) {
//                           //               setState(() {
//                           //                 cartLoading = false;
//                           //               });
//                           //               Navigator.of(context)
//                           //                   .pushNamed("/Login");
//                           //             } else {
//                           //               if (_productController
//                           //                   .isSameMarkets(
//                           //                   _con.products[i])) {
//                           //                 _productController
//                           //                     .addToCart(
//                           //                     _con.products[i]);
//                           //                 Future.delayed(
//                           //                     Duration(seconds: 3),
//                           //                         () {
//                           //                       refreshCart();
//                           //                       _productController
//                           //                           .listenForCart();
//                           //                       setState(() {
//                           //                         cartLoading = false;
//                           //                       });
//                           //                     });
//                           //               } else {
//                           //                 showDialog(
//                           //                   context: context,
//                           //                   builder: (BuildContext
//                           //                   context) {
//                           //                     // return object of type Dialog
//                           //                     return AddToCartAlertDialogWidget(
//                           //                         oldProduct:
//                           //                         _productController
//                           //                             .carts
//                           //                             .elementAt(
//                           //                             0)
//                           //                             ?.product,
//                           //                         newProduct: _con
//                           //                             .products[
//                           //                         selectedIndex],
//                           //                         onPressed: (product,
//                           //                             {reset: true}) {
//                           //                           _productController
//                           //                               .addToCart(
//                           //                               product,
//                           //                               reset:
//                           //                               reset);
//                           //                           Future.delayed(
//                           //                               Duration(
//                           //                                   seconds:
//                           //                                   3),
//                           //                                   () {
//                           //                                 refreshCart();
//                           //                                 _productController
//                           //                                     .listenForCart();
//                           //
//                           //                                 setState(() {
//                           //                                   cartLoading =
//                           //                                   false;
//                           //                                 });
//                           //                               });
//                           //                           return;
//                           //                         });
//                           //                   },
//                           //                 );
//                           //               }
//                           //             }
//                           //           });
//                           //         },
//                           //         child: CardWidget(
//                           //             product: _con.products[i]),
//                           //       );
//                           //     },
//                           //   ),
//                           // ),
//                           // SizedBox(
//                           //   height: ScreenUtil().setHeight(5),
//                           // ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Menu',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:
//                                       ScreenUtil().setSp(17)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: ScreenUtil().setHeight(5),
//                           ),
//                           // Expanded(
//                           //   child: ListView.builder(
//                           //     itemCount: _con.products.length,
//                           //     itemBuilder: (context, i) {
//                           //       return InkWell(
//                           //         onTap: (){
//                           //           setState(() {
//                           //             cartLoading = true;
//                           //           });
//                           //
//                           //           // if (!isPresent) {
//                           //           print(_con.products[i].name);
//                           //           setState(() {
//                           //             selectedIndex = i;
//                           //             //  List<Product> products = List<Product>();
//                           //             products.add(_con.products[i]);
//                           //             // products.add(SelectedOrderItem(id: _con.products[index].id,name:  _con.products[index].name,imageUrl:  _con.products[index].image.url,price:_con.products[index].price ));
//                           //             products.toSet().toList();
//                           //
//                           //             print('index  $i');
//                           //
//                           //             if (currentUser
//                           //                 .value.apiToken ==
//                           //                 null) {
//                           //               setState(() {
//                           //                 cartLoading = false;
//                           //               });
//                           //               Navigator.of(context)
//                           //                   .pushNamed("/Login");
//                           //             } else {
//                           //               if (_productController
//                           //                   .isSameMarkets(
//                           //                   _con.products[i])) {
//                           //                 _productController
//                           //                     .addToCart(
//                           //                     _con.products[i]);
//                           //                 Future.delayed(
//                           //                     Duration(seconds: 3),
//                           //                         () {
//                           //                       refreshCart();
//                           //                       _productController
//                           //                           .listenForCart();
//                           //                       setState(() {
//                           //                         cartLoading = false;
//                           //                       });
//                           //                     });
//                           //               } else {
//                           //                 showDialog(
//                           //                   context: context,
//                           //                   builder: (BuildContext
//                           //                   context) {
//                           //                     // return object of type Dialog
//                           //                     return AddToCartAlertDialogWidget(
//                           //                         oldProduct:
//                           //                         _productController
//                           //                             .carts
//                           //                             .elementAt(
//                           //                             0)
//                           //                             ?.product,
//                           //                         newProduct: _con
//                           //                             .products[
//                           //                         selectedIndex],
//                           //                         onPressed: (product,
//                           //                             {reset: true}) {
//                           //                           _productController
//                           //                               .addToCart(
//                           //                               product,
//                           //                               reset:
//                           //                               reset);
//                           //                           Future.delayed(
//                           //                               Duration(
//                           //                                   seconds:
//                           //                                   3),
//                           //                                   () {
//                           //                                 refreshCart();
//                           //                                 _productController
//                           //                                     .listenForCart();
//                           //
//                           //                                 setState(() {
//                           //                                   cartLoading =
//                           //                                   false;
//                           //                                 });
//                           //                               });
//                           //                           return;
//                           //                         });
//                           //                   },
//                           //                 );
//                           //               }
//                           //             }
//                           //           });
//                           //         },
//                           //
//                           //         child: CardWidget(
//                           //             product:  _con.products[i]
//                           //         ),
//                           //       );
//                           //     },
//                           //   ),
//                           // ),
//                           Expanded(
//                             child: GridView.builder(
//                                 gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                   //  maxCrossAxisExtent: 200,
//                                     crossAxisCount: 3,
//                                     childAspectRatio: height < 700 ? 0.7 : 0.55,
//                                     crossAxisSpacing: 20,
//                                     mainAxisSpacing: 5),
//                                 itemCount: _con.products.length,
//                                 semanticChildCount: 3,
//                                 itemBuilder: (BuildContext ctx, index) {
//                                   return CardWidget(
//                                     product: _con.products[index],
//                                   );
//                                 }),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Cart',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:
//                                       ScreenUtil().setSp(17)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: ScreenUtil().setHeight(5),
//                           ),
//                           Expanded(
//                             child: Container(
//
//                                 height: 170,
//                                 child: cartLoading
//                                     ? Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                       BorderRadius.circular(
//                                           25.0),
//                                       // color: Colors.greenAccent,
//                                     ),
//                                     child: Image.asset(
//                                       'assets/img/loading.gif',
//                                       fit: BoxFit.cover,
//                                       width: 200,
//                                     ))
//                                     : KitchenCartWidget(
//                                     callback: (func) {
//                                       refreshCart = func;
//                                     }, removeFromCart: () {
//                                   Future.delayed(
//                                       Duration(milliseconds: 30),
//                                           () {
//                                         _productController
//                                             .listenForCart();
//                                         refreshCart();
//                                       });
//                                 })),
//                           ),
// //calender here
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtil.screenHeight * 0.76,
              width: ScreenUtil.screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14),
                child: SingleChildScrollView(
                  child: Container(
                    height: ScreenUtil.screenHeight * 0.76,
                    width: ScreenUtil.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: ScreenUtil.screenHeight * 0.33,
                        ),
                        Text(
                          'Menu',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(17)),
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                //  maxCrossAxisExtent: 200,
                                  crossAxisCount: 3,
                                  childAspectRatio: height < 700 ? 0.7 : 0.55,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 5
                              ),
                              itemCount: _con.products.length,
                              semanticChildCount: 3,
                              itemBuilder: (BuildContext ctx, index) {
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      cartLoading = true;
                                    });

                                    // if (!isPresent) {
                                    print(_con.products[index].name);
                                    setState(() {
                                      selectedIndex = index;
                                      //  List<Product> products = List<Product>();
                                      products.add(_con.products[index]);
                                      // products.add(SelectedOrderItem(id: _con.products[index].id,name:  _con.products[index].name,imageUrl:  _con.products[index].image.url,price:_con.products[index].price ));
                                      products.toSet().toList();

                                      print('index  $index');

                                      if (currentUser
                                          .value.apiToken ==
                                          null) {
                                        setState(() {
                                          cartLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushNamed("/Login");
                                      } else {
                                        if (_productController
                                            .isSameMarkets(
                                            _con.products[index])) {
                                          _productController
                                              .addToCart(
                                              _con.products[index]);
                                          Future.delayed(
                                              Duration(seconds: 3),
                                                  () {
                                                refreshCart();
                                                _productController
                                                    .listenForCart();
                                                setState(() {
                                                  cartLoading = false;
                                                });
                                              });
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext
                                            context) {
                                              // return object of type Dialog
                                              return AddToCartAlertDialogWidget(
                                                  oldProduct:
                                                  _productController
                                                      .carts
                                                      .elementAt(
                                                      0)
                                                      ?.product,
                                                  newProduct: _con
                                                      .products[
                                                  selectedIndex],
                                                  onPressed: (product,
                                                      {reset: true}) {
                                                    _productController
                                                        .addToCart(
                                                        product,
                                                        reset:
                                                        reset);
                                                    Future.delayed(
                                                        Duration(
                                                            seconds:
                                                            3),
                                                            () {
                                                          refreshCart();
                                                          _productController
                                                              .listenForCart();

                                                          setState(() {
                                                            cartLoading =
                                                            false;
                                                          });
                                                        });
                                                    return;
                                                  });
                                            },
                                          );
                                        }
                                      }
                                    });
                                  },

                                  child: CardWidget(
                                    product: _con.products[index],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        Expanded(
                          child: Container(

                              height: 170,
                              child: cartLoading
                                  ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(
                                        25.0),
                                    // color: Colors.greenAccent,
                                  ),
                                  child: Image.asset(
                                    'assets/img/loading.gif',
                                    fit: BoxFit.cover,
                                    width: 200,
                                  ))
                                  : KitchenCartWidget(
                                  callback: (func) {
                                    refreshCart = func;
                                  }, removeFromCart: () {
                                Future.delayed(
                                    Duration(milliseconds: 30),
                                        () {
                                      _productController
                                          .listenForCart();
                                      refreshCart();
                                    });
                              })),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
              top: ScreenUtil.screenHeight * 0.22,
              right: 10,
              left: 10,
              child: Container(
                height: ScreenUtil.screenHeight * 0.367,
                width: ScreenUtil.screenWidth,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    Text(
                      langCode=='en'? _con.market?.name??'' :_con.market?.nameAr  ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(20)),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.black
                              .withOpacity(0.7),
                        ),
                        Text(
                          _con.market
                              ?.address ??
                              '',
                          overflow: TextOverflow
                              .ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(17),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Text(
                      'Resturent Achivements ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(17)),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Container(
                      height: ScreenUtil.screenHeight * 0.135,
                      width: ScreenUtil.screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, i) {
                          return Card(
                            child: Column(
                              children: [
                                Container(
                                  height: ScreenUtil.screenHeight * 0.085,
                                  width: ScreenUtil.screenWidth * 0.25,
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Fast food'),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            top: ScreenUtil.screenHeight * 0.18,
            child: Center(
              child: Container(
                width: ScreenUtil.screenWidth,
                child: Container(
                    width: ScreenUtil().setWidth(70),
                    height: ScreenUtil().setHeight(70),
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black
                      // image: new DecorationImage(
                      //   image: new ExactAssetImage('assets/4.png'),
                      //   fit: BoxFit.cover,
                      // ),
                    )),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CardWidget extends StatelessWidget {
  Product product;
  CardWidget({
    this.product,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        product == null
            ?   Container(
          height: ScreenUtil.screenHeight * 0.13,
          width: ScreenUtil.screenWidth * 0.4,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.black.withOpacity(0.4)),
        ): Container(
          height: ScreenUtil.screenHeight * 0.13,
          width: ScreenUtil.screenWidth * 0.4,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.image.url)),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.black.withOpacity(0.4)),
        ) ,
        Container(
          height: ScreenUtil.screenHeight * 0.1,
          width: ScreenUtil.screenWidth / 2.2,
          color: Colors.white.withOpacity(0.3),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product != null ? product.name:    'Chicken',
                  style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5),
                ),
                Text(
                  product != null ? product.price.toString() :   '\$100.00',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(16), color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },

              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white.withOpacity(0.4)),
                child: Center(child: Icon(Icons.arrow_back_ios)),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Colors.white.withOpacity(0.4)),
              child: Center(child: Icon(Icons.bookmark_border_sharp)),
            )
          ],
        ),
      ),
    );
  }
}
